# Raid10 on Rockylinux8.6

Этот Vagrantfile запускает машину с созданным массивом RAID10, массив монтирует в директрию: /home/vagrant/raid_disk 
и создает несколько тестовых файлов

после перезагрузки все изменения сохраняються, проверить что смонтирвано в директорию raid_disk можно коммандой: ``` df -h raid_disk ``` выполнив ее в домашнем каталоге.

скрипт по созданию массива и настройки монтирования находиться в директории files

![RAID_10](https://user-images.githubusercontent.com/59445051/202411305-37a70b6a-58d4-4fee-8f7a-fc7a1b052324.svg)
