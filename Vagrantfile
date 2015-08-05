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

  config.vm.define "mapr-1" do |config|
    file_to_disk = "mapr-1-disk"

    unless File.exist?(file_to_disk)
      config.vm.customize ['createhd', '--filename', file_to_disk,
                           '--size', 500 * 1024]
    end
    config.vm.customize ['storageattach', :id, '--storagectl',
                         'IDE Controller', '--port', 1, '--device', 0
                         , '--type', 'hdd', '--medium', file_to_disk]
                           
    config.vm.network "private_network", ip: "172.20.20.11"
    config.vm.hostname = "mapr-1"
    config.vm.provision "chef_solo" do |chef|
      chef.roles_path = "roles"

      chef.run_list = [
        "recipe[consul]",
        "recipe[consul-template]",
        "role[mapr_consul_zookeeper]",
        "role[mapr_consul_fileserver]",
        "role[mapr_consul_cldb]"        
      ]

      chef.json = {
        "consul" => {
          "extra_params" => {
            "advertise_addr" => "172.20.20.11"
          },
          "servers" => ["172.20.20.10"]
        }
      }
    end
  end
end
