# Vagrant Lamp

LAMP development-stack configuration for Vagrant.

## Requirements

* Virtualbox
* Vagrant >= 1.7.0

## Installation

1. Download and install [VirtualBox](http://www.virtualbox.org/)

2. Download and install [vagrant](http://vagrantup.com/)

3. Clone the repository

4. cd into the repository folder and launch the vagrant box:

```bash
$ cd [dir]
$ vagrant up
```

## Whats included

* Apache 2.4
* MySQL 5.7
* PHP 7.3

## MySQL

For connecting to the MySQL Database use the following credentials:
```
 User: root
 Password: geheim
```

## Usage
For usage within your project add the following to your `Vagrantfile`:
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "dnkfbrknme/vagrant-lamp"
  # network
  config.vm.network "private_network", ip: "192.168.33.10"
  # disk
  config.vm.synced_folder ".", "/var/www/html", :mount_options => ["dmode=777", "fmode=666"]
end
```
