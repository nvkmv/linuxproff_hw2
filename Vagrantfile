# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :rockybox => {
        :box_name => "nvkmv/rockylinux8.6",
        :ip_addr => '192.168.1.55',
	:disks => {
		:sata1 => {
			:dfile => './sata1.vdi',
			:size => 250,
			:port => 1
		},
		:sata2 => {
                        :dfile => './sata2.vdi',
                        :size => 250, # Megabytes
			:port => 2
		},
                :sata3 => {
                        :dfile => './sata3.vdi',
                        :size => 250,
                        :port => 3
                },
                :sata4 => {
                        :dfile => './sata4.vdi',
                        :size => 250, # Megabytes
                        :port => 4
                }

	}

		
  },
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|
          config.vm.synced_folder "./files", "/home/vagrant/files"
          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset

          box.vm.network "public_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            	  #vb.customize ["modifyvm", :id, "--memory", "1024"]
                  vb.check_guest_additions=false
                  needsController = false
		  boxconfig[:disks].each do |dname, dconf|
			  unless File.exist?(dconf[:dfile])
				vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                needsController =  true
                          end

		  end
                  if needsController == true
                     vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                     boxconfig[:disks].each do |dname, dconf|
                         vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                     end
                  end
          end
 	  box.vm.provision "shell", inline: <<-SHELL
	      mkdir -p ~root/.ssh
	      dnf install -y git mdadm smartmontools hdparm gdisk
              bash /home/vagrant/files/script.sh
              runuser vagrant -c sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
              sed -i 's|vagrant:x:1000:1000::/home/vagrant:/bin/bash|vagrant:x:1000:1000::/home/vagrant:/bin/zsh|' /etc/passwd
              sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="daveverwer"|' /home/vagrant/.zshrc 
          SHELL
      end
  end
end

