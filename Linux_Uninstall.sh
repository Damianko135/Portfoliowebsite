#!/bin/bash

sudo systemctl restart apache2

# Remove the cloned repository and reset the destination directory
sudo rm -rf "$destination_dir"

# Uninstall packages
sudo apt purge -y curl apache2 mysql-server php libapache2-mod-php php-mysql git
sudo apt autoremove -y
sudo apt autoclean -y


