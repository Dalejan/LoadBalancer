Vagrant.configure("2") do |config|
    config.vm.define :haproxyUbuntu do |haproxyUbuntu|
        haproxyUbuntu.vm.box = "bento/ubuntu-20.04"
        haproxyUbuntu.vm.network :private_network, ip: "192.168.100.2"
        haproxyUbuntu.vm.hostname = "haproxyUbuntu"
        haproxyUbuntu.vm.synced_folder "./content/haproxy", "/content"
        haproxyUbuntu.vm.provision "shell", path: "bootstrap.sh", args: ["haproxy", "updateFiles"]
    end

    config.vm.define :web1Ubuntu do |web1Ubuntu|
        web1Ubuntu.vm.box = "bento/ubuntu-20.04"
        web1Ubuntu.vm.hostname = "web1Ubuntu"
        web1Ubuntu.vm.network :private_network, ip: "192.168.100.3"
        web1Ubuntu.vm.synced_folder "./content/web1", "/content"
        web1Ubuntu.vm.provision "shell", path: "bootstrap.sh", args: ["web1","updateFiles"]
    end

    config.vm.define :web2Ubuntu do |web2Ubuntu|
        web2Ubuntu.vm.box = "bento/ubuntu-20.04"
        web2Ubuntu.vm.hostname = "web2Ubuntu"
        web2Ubuntu.vm.network :private_network, ip: "192.168.100.4"
        web2Ubuntu.vm.synced_folder "./content/web2", "/content"
        web2Ubuntu.vm.provision "shell", path: "bootstrap.sh", args: ["web2", "updateFiles"]
    end

    config.vm.define :web3Ubuntu do |web3Ubuntu|
        web3Ubuntu.vm.box = "bento/ubuntu-20.04"
        web3Ubuntu.vm.hostname = "web3Ubuntu"
        web3Ubuntu.vm.network :private_network, ip: "192.168.100.33"
        web3Ubuntu.vm.synced_folder "./content/web3", "/content"
        web3Ubuntu.vm.provision "shell", path: "bootstrap.sh", args: ["web3","updateFiles"]
      end
  
    config.vm.define :web4Ubuntu do |web4Ubuntu|
        web4Ubuntu.vm.box = "bento/ubuntu-20.04"
        web4Ubuntu.vm.hostname = "web4Ubuntu"
        web4Ubuntu.vm.network :private_network, ip: "192.168.100.44"
        web4Ubuntu.vm.synced_folder "./content/web4", "/content"
        web4Ubuntu.vm.provision "shell", path: "bootstrap.sh", args: ["web4", "updateFiles"]
    end


    config.vm.define :web5Ubuntu do |web5Ubuntu|
        web5Ubuntu.vm.box = "bento/ubuntu-20.04"
        web5Ubuntu.vm.hostname = "webUbuntu"
        web5Ubuntu.vm.network :private_network, ip: "192.168.100.5"
        web5Ubuntu.vm.synced_folder "./content/web5", "/content"
        web5Ubuntu.vm.provision "shell", path: "bootstrap.sh", args: ["web5", "updateFiles"]
    end

  end
  

  #Print haproxy errors
  #haproxy -f /etc/haproxy/haproxy.cfg -db
