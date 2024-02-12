#!/bin/bash

# Uninstall Apache, MySQL, PHP, Git
sudo apt purge apache2 mysql-server php libapache2-mod-php php-mysql git -y
sudo apt autoremove -y && sudo apt autoclean -y
# Remove website files
sudo rm -rf /var/www/html


# Remove firewall rules
sudo ufw delete allow 'OpenSSH'
sudo ufw delete allow "Apache Full"

# Reload firewall
sudo ufw reload