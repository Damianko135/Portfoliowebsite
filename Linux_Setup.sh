#!/bin/bash

## Change the variables accordingly
# This is how you can pull my portfolio website and to setup almost everything that i used. With the exception being my own passwords.
destination_dir="/var/www/html/"
Virtual_Host="/var/www/html/Index"
branch="main"  # Change this to your desired branch
github_repo="https://github.com/Damianko135/Portfoliowebsite.git"
directory="Index"  # Change this to the directory you want to pull

# Update system packages and upgrade kept back packages
sudo apt update
sudo apt full-upgrade -y

# Upgrade held back packages

# Install necessary packages: curl, Apache, firewall, MySQL, PHP, Git
sudo apt install curl apache2 ufw mysql-server php libapache2-mod-php php-mysql git -y

# Allow SSH and Apache through the firewall
sudo ufw allow 'OpenSSH'
sudo ufw allow "Apache Full"
sudo a2enmod rewrite

sudo rm -rf /var/www/html/

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
fi

### Edit Apache Virtual Host Configuration
## This section updates the Apache virtual host configuration to point to the correct directory.
# It also allows .htaccess files to override Apache configuration settings.
# The virtual host configuration file path
VHOST_FILE="/etc/apache2/sites-available/000-default.conf"

# Backup the original configuration file
sudo cp $VHOST_FILE "${VHOST_FILE}.bak"

# Set the document root to the destination directory
sudo sed -i "s#DocumentRoot /var/www/html#DocumentRoot $Virtual_Host#" $VHOST_FILE || echo "Couldn't update the Virtual Host"

# Allow .htaccess files to override settings
echo "<Directory $Virtual_Host>
    AllowOverride All
</Directory>" | sudo tee -a /etc/apache2/sites-available/000-default.conf > /dev/null

# Reload Apache to apply changes
sudo systemctl restart apache2 && echo 'Apache reloaded'|| echo 'Cannot reload apache'

sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages
# Schedule permissions reset after 10 minutes.
(sleep 600 && sudo chmod -R 755 /var/www/html/*) &
