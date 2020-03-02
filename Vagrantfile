Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    # installation
    config.vm.provision "shell", path: "provision/install.sh"

    # networking
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 3306, host: 3306
    config.vm.network "private_network", ip: "192.168.33.10"

    # disk
    config.vm.synced_folder ".", "/var/www/html", :mount_options => ["dmode=777", "fmode=666"]
end
