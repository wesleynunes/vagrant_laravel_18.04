Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "laravelbionic"
    config.vm.network :private_network, ip: "192.168.33.90" 
    config.vm.synced_folder("./", "/var/www/html", :nfs => true)
    config.vm.provider "virtualbox" do |machine|
    	machine.memory = 3024
        machine.cpus = 2
    	machine.name = "laravelbionic"
    end
    # config.vm.provision :shell, path: "setup.sh"
    # config.vm.provision :shell, path: "project01.sh"
    # config.vm.provision :shell, path: "project02.sh"
    # config.vm.provision :shell, path: "project03.sh"
    # config.vm.provision :shell, path: "project04.sh"
    # config.vm.provision :shell, path: "project05.sh"
end
