#!/bin/bash

# Variables from the other script
destination_dir="/var/www/html/"
Virtual_Host="/var/www/html/Index"

# Remove permissions reset scheduled after 10 minutes
ps -ef | grep "sudo chmod -R 755 $destination_dir/*" | grep -v grep | awk '{print $2}' | xargs sudo kill

# Undo changes to Apache Virtual Host Configuration
sudo sed -i "s#DocumentRoot $Virtual_Host#DocumentRoot /var/www/html#" /etc/apache2/sites-available/000-default.conf
sudo sed -i '/<Directory \/var\/www\/html>/,/<\/Directory>/d' /etc/apache2/sites-available/000-default.conf
sudo rm -f /etc/apache2/sites-available/000-default.conf.bak
sudo systemctl restart apache2

# Remove the cloned repository and reset the destination directory
sudo rm -rf "$destination_dir"

# Uninstall packages
sudo apt purge -y curl apache2 mysql-server php libapache2-mod-php php-mysql git
sudo apt autoremove -y
sudo apt autoclean -y


