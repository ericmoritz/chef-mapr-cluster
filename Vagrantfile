# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end
  #config.hostmanager.enabled = true
  #config.hostmanager.manage_host = true


  config.vm.box = 'chef/centos-6.5'
  config.berkshelf.enabled = true

  config.vm.define "consul" do |config|
    config.vm.network "private_network", ip: "172.20.20.10"
    config.vm.hostname = "consul-1"
    config.vm.provision "chef_solo" do |chef|
      chef.run_list = [
        "recipe[consul]"
      ]
      chef.json = {
        "consul" => {
          "service_mode" => "server",
          "extra_params" => {
            "bootstrap_expect" => 1,
            "advertise_addr" => "172.20.20.10"
          }
        }
      }

    end
  end
  nodes = [
    # The first two are the HA nodes
    {
      'run_list' => [
        "recipe[consul]",
        "recipe[consul-template]",
        "role[mapr_consul_zookeeper]",
        "role[mapr_consul_fileserver]",
        "role[mapr_consul_cldb]",
        "role[mapr_consul_resourcemanager]",
        "role[mapr_consul_nodemanager]"
      ]
    },
    {
      'run_list' => [
        "recipe[consul]",
        "recipe[consul-template]",
        "role[mapr_consul_zookeeper]",
        "role[mapr_consul_fileserver]",
        "role[mapr_consul_cldb]",
        "role[mapr_consul_resourcemanager]",
        "role[mapr_consul_nodemanager]"
      ]
    },
    # The third node is everything else
    {
      'run_list' => [
        "recipe[consul]",
        "recipe[consul-template]",
        "role[mapr_consul_zookeeper]",
        "role[mapr_consul_fileserver]",
        "role[mapr_consul_nodemanager]",
        "role[mapr_consul_historyserver]",
        "role[mapr_consul_webserver]"                
      ]
    },

  ]

  (1..3).each do |i|
    name = "mapr-#{i}"  
    ip = "172.20.20.#{10+i}"
    file_to_disk = "./#{name}-disk.vdi"

    config.vm.define name do |config|
      
      config.vm.provider "virtualbox" do | v |
        v.memory = 1024

        unless File.exist?(file_to_disk)
          v.customize ['createhd', '--filename', file_to_disk, '--size', 500 * 1024]
        end
        v.customize [
          'storageattach', :id, '--storagectl', 'IDE Controller',
          '--port', 1, '--device', 0, '--type', 'hdd', '--medium',
          file_to_disk
        ]

      end
                           
      config.vm.network "private_network", ip: ip
      config.vm.hostname = "#{name}"
      config.vm.provision "chef_solo" do |chef|
        chef.roles_path = "roles"

        chef.run_list = nodes[i-1]['run_list']
        chef.json = {
          "mapr_consul" => {
            "isvm" => true
          },
          "consul" => {
            "extra_params" => {
              "advertise_addr" => ip
            },
            "servers" => ["172.20.20.10"]
          }
        }
      end
    end
  end
end
