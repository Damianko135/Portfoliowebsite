#!/bin/bash

# Check if script is being run by cron
# If the script is being executed in an SSH session, it cannot be run by cron,
# so we exit with an error message.
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "This script cannot be run by cron."
    exit 1
fi

# Get the username of the person who executes the script
# This will be used later for setting permissions on directories.
USER=$(whoami)

# Prompt the user to set the SQL password
echo "Set SQL Password"
read -s SQL_Password

# Prompt the user to specify the virtual host directory
echo "Which part of the virtual host? (/var/www/ ???)"
read -p "Directory path: " Active_Dir

# Update the repositories from the server OS Repository.
# This ensures we have the latest package information.
sudo apt update && sudo apt full-upgrade

# Install curl
# Curl is a command-line tool for transferring data with URL syntax.
sudo apt install curl -y

# Get public IP address using curl, the tool just installed
# Here, we use it to obtain the public IP address of the server.
IP=$(curl -s https://ipv4.icanhazip.com)

# Install Apache
# Apache is a widely used web server software. But you can use anyone you'd like.
sudo apt install apache2 -y

# Allow Apache through the firewall
# This command opens up necessary ports for Apache to function properly.
sudo ufw allow "Apache Full"

# Install MySQL server and secure installation
# MySQL is a popular relational database management system.
# This command installs MySQL server and initiates a secure installation process.
sudo apt install mysql-server -y
sudo mysql_secure_installation <<< $SQL_Password

# Install PHP and its modules
# PHP is a server-side scripting language used for web development.
sudo apt install php libapache2-mod-php php-mysql -y

# Restart Apache
# This command restarts the Apache web server to apply changes after installing PHP.
sudo systemctl restart apache2

# Set default directory path
# If the user input does not contain a '/', it's likely a relative path, so we set the default directory path.
DEFAULT_DIR="/var/www/html"

# Determine directory path
# If the user input does not contain a '/', we use the default directory path.
if [[ "$Active_Dir" != /* ]]; then
    Active_Dir="$DEFAULT_DIR"
fi

# Remove trailing slash if present
# This removes a trailing slash from the directory path to ensure consistency.
Active_Dir="${Active_Dir%/}"

# Allow user to access $Active_Dir/* with WinSCP
# This command sets permissions for the specified directory, allowing the user to access it with WinSCP.
sudo chown -R $USER:$USER "$Active_Dir"/*
sudo chmod -R 777 "$Active_Dir"/*


# Clone or update website repository
# This section clones or updates a website repository from GitHub.
Website='https://github.com/Gamelink2/BBB.git'
branch='main'

if [ ! -d "$Active_Dir" ]; then
    # Clone the repository if it doesn't exist
    git clone -b "$branch" --single-branch $Website $Active_Dir
else
    # Navigate into the existing repository directory
    cd $Active_Dir || exit

    # Update the existing repository
    git fetch origin "$branch"
    git reset --hard "origin/$branch"
    git clean -df
fi

# Remove permissions after 3 hours
# This background process removes permissions for the directory after 3 hours.
(sleep 10800 && sudo chmod -R 755 "$Active_Dir"/*) &