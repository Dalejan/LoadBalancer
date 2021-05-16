Vagrant.configure("2") do |config|
    config.vm.define :haproxyUbuntu do |haproxyUbuntu|
      haproxyUbuntu.vm.box = "bento/ubuntu-20.04"
      haproxyUbuntu.vm.network :private_network, ip: "192.168.100.1"
      haproxyUbuntu.vm.hostname = "haproxyUbuntu"
      haproxyUbuntu.vm.provision "shell", path: "bootstrap.sh", args: "haproxy"
    end
    config.vm.define :web1Ubuntu do |web1Ubuntu|
      web1Ubuntu.vm.box = "bento/ubuntu-20.04"
      web1Ubuntu.vm.hostname = "web1Ubuntu"
      web1Ubuntu.vm.network :private_network, ip: "192.168.100.2"
    end
    config.vm.define :web2Ubuntu do |web2Ubuntu|
      web2Ubuntu.vm.box = "bento/ubuntu-20.04"
      web2Ubuntu.vm.hostname = "web2Ubuntu"
      web2Ubuntu.vm.network :private_network, ip: "192.168.100.3"
    end
  end