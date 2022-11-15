#!/bin/bash
mkdir /home/vagrant/raid_disk
sudo mkdir /etc/mdadm
sudo touch /etc/mdadm/mdadm.conf
sudo chmod 777 /etc/mdadm/mdadm.conf
sudo mdadm --create /dev/md0 -l 10 -n4 /dev/sd{b,c,d,e}
sudo echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
sudo mdadm -D --scan | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
sudo mkfs.ext4 /dev/md0
sudo mount /dev/md0 /home/vagrant/raid_disk/
sudo tail -1 /etc/mtab >> /etc/fstab
sudo touch /home/vagrant/raid_disk/file{1..4}
