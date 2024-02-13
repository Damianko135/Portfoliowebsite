#!/bin/bash

# Variables from the other script
destination_dir="/var/www/html/"
Virtual_Host="/var/www/html/Index"

# Remove permissions reset scheduled after 10 minutes
ps -ef | grep "sudo chmod -R 755 $destination_dir" | grep -v grep | grep -v $$ | awk '{print $2}' | xargs sudo kill -9

# Remove the cloned repository and reset the destination directory
sudo rm -rf "$destination_dir"

# Uninstall packages
sudo apt purge -y curl apache2 mysql-server php libapache2-mod-php php-mysql
sudo apt autoremove -y
sudo apt autoclean -y
