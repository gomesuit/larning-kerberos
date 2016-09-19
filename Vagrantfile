# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
ifdown eth1
ifup eth1
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.box = "centos/7"
  config.ssh.insert_key = false
  config.vm.provision :shell, inline: $script

  #config.vm.provider :virtualbox do |vb|
  #  vb.customize ["modifyvm", :id, "--memory", "3072"]
  #end

  config.vm.define "private" do |host|
    host.vm.hostname = "private"
    host.vm.network "private_network", ip: "192.168.33.60"
    host.vm.provision :shell, :path => "provision.sh"
  end

end
