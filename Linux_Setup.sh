#!/bin/bash

## Change the variables accordingly
# This is how you can pull my portfolio website and to setup almost everything that i used. With the exception being my own passwords.
destination_dir="/var/www/html/Index"
branch="main"  # Change this to your desired branch
github_repo="https://github.com/Damianko135/Portfoliowebsite.git"
directory="Index"  # Change this to the directory you want to pull

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
sudo a2enmod rewrite
sudo systemctl restart apache2

# Adjust permissions for default directory
sudo mkdir -p /var/www/html
sudo chown -R "$(whoami)":"$(whoami)" /var/www/html
sudo chmod -R 755 /var/www/html

# Destination directory where you want to place the files

# Check if the destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    sudo mkdir -p "$destination_dir"
fi

# Navigate to the destination directory
cd "$destination_dir" || exit

# Clone or update the repository
if [ ! -d ".git" ]; then
    # Clone the repository if it doesn't exist
    sudo git clone -b "$branch" --single-branch "$github_repo" .
else
    # Update the existing repository
    sudo git fetch origin "$branch"
    sudo git clean -df
fi

# Schedule permissions reset after 3 hours
(sleep 10800 && sudo chmod -R 755 /var/www/html/*) &
