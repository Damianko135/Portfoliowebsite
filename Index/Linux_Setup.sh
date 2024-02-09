#!/bin/bash

# Update system packages and upgrade kept back packages
sudo apt update
sudo apt full-upgrade -y

# Upgrade held back packages
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages

# Install necessary packages: curl, Apache, firewall, MySQL, PHP, Git
sudo apt install curl apache2 ufw mysql-server php libapache2-mod-php php-mysql git -y

# Allow SSH and Apache through the firewall
sudo ufw allow 'OpenSSH'
sudo ufw allow "Apache Full"
sudo systemctl restart apache2

# Adjust permissions for default directory
sudo chown -R "$(whoami)":"$(whoami)" /var/www/html/*
sudo chmod -R 755 /var/www/html/*

# Change directory to the default directory
cd /var/www/html || exit

# Clone the repository if it doesn't exist, otherwise pull updates
if [ ! -d "Portfoliowebsite" ]; then
    sudo git clone https://github.com/Damianko135/Portfoliowebsite .
else
    sudo git pull origin main
fi

# Schedule permissions reset after 3 hours
(sleep 10800 && sudo chmod -R 755 /var/www/html/*) &
