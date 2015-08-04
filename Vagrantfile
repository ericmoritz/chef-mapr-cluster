# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true


  config.vm.box = 'chef/centos-6.5'
  config.berkshelf.enabled = true

  config.vm.define "consul" do |config|
    config.vm.network "public_network", dhcp: true
    config.vm.hostname = "consul-1"
    config.vm.provision "chef_solo" do |chef|
      chef.run_list = ["recipe[consul]"]
    end
  end

  config.vm.define "mapr-1" do |config|
    config.vm.network "public_network", dhcp: true
    config.vm.hostname = "mapr-1"
    config.vm.provision "chef_solo" do |chef|
      chef.roles_path = "roles"

      chef.run_list = [
        "role[mapr_consul_zookeeper]"
      ]
    end
  end
end
