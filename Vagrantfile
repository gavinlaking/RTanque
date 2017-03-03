# Getting started:
#
# vagrant box add precise32 http://files.vagrantup.com/precise32.box
# vagrant up
# vagrant ssh
#
#
Vagrant.configure("2") do |config|
  config.puppet_install.puppet_version = :latest

  # config.ssh.insert_key = "~/.ssh/id_rsa.pub"
  # config.vm.provider "docker" do |d|
  #   d.build_dir = "."
  #   d.force_host_vm = true
  #   d.has_ssh = true
  #   d.remains_running = true
  # end

  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "rtanque.box"
  config.vm.network :private_network, ip: "192.168.0.10"

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--cpuexecutioncap", "75",
      "--memory", "1024",
    ]
  end



  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
  end
end

