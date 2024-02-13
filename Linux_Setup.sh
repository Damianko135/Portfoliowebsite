#!/bin/bash

# Change the variables accordingly
destination_dir="/var/www/html/"
Virtual_Host="/var/www/html/Index"
branch="main"  # Change this to your desired branch
github_repo="https://github.com/Damianko135/Portfoliowebsite.git"
directory="Index"  # Change this to the directory you want to pull

# Function to handle errors
handle_error() {
    local error_message="$1"
    echo "Error: $error_message" >&2
    exit 1
}

# Update system packages and upgrade kept back packages
sudo apt update || handle_error "Failed to update system packages"
sudo apt full-upgrade -y || handle_error "Failed to upgrade system packages"

# Upgrade held back packages
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages || handle_error "Failed to upgrade held back packages"

# Install necessary packages: curl, Apache, firewall, MySQL, PHP, Git
sudo apt install curl apache2 ufw mysql-server php libapache2-mod-php php-mysql git -y || handle_error "Failed to install necessary packages"

# Allow SSH and Apache through the firewall
sudo ufw allow 'OpenSSH' || handle_error "Failed to allow SSH through firewall"
sudo ufw allow "Apache Full" || handle_error "Failed to allow Apache through firewall"
sudo a2enmod rewrite || handle_error "Failed to enable Apache rewrite module"

sudo rm -rf /var/www/html/ || handle_error "Failed to remove existing HTML directory"

# Adjust permissions for default directory
sudo mkdir -p /var/www/html || handle_error "Failed to create HTML directory"
sudo chown -R "$(whoami)":"$(whoami)" /var/www/html || handle_error "Failed to set ownership for HTML directory"
sudo chmod -R 755 /var/www/html || handle_error "Failed to set permissions for HTML directory"

# Destination directory where you want to place the files

# Check if the destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    sudo mkdir -p "$destination_dir" || handle_error "Failed to create destination directory"
fi

# Navigate to the destination directory
cd "$destination_dir" || handle_error "Failed to navigate to destination directory"

# Stash local changes to Connection.php if any

# Clone or update the repository
if [ ! -d ".git" ]; then
    # Clone the repository if it doesn't exist
    sudo git clone -b "$branch" --single-branch "$github_repo" . || handle_error "Failed to clone repository"
else
    # Update the existing repository
    git stash save "Stashing local changes to Connection.php" || handle_error "Failed to stash local changes to Connection.php"
    sudo git fetch origin "$branch" || handle_error "Failed to fetch updates from repository"
    git stash apply || handle_error "Failed to apply stashed changes to Connection.php"
fi


### Edit Apache Virtual Host Configuration
## This section updates the Apache virtual host configuration to point to the correct directory.
# It also allows .htaccess files to override Apache configuration settings.
# The virtual host configuration file path
VHOST_FILE="/etc/apache2/sites-available/000-default.conf"

# Backup the original configuration file if not already backed up
if [ ! -f "${VHOST_FILE}.bak" ]; then
    sudo cp "$VHOST_FILE" "${VHOST_FILE}.bak" || handle_error "Failed to backup Apache virtual host configuration"
    
    # Set the document root to the destination directory
    sudo sed -i "s#DocumentRoot /var/www/html#DocumentRoot $Virtual_Host#" "$VHOST_FILE" || handle_error "Failed to update Apache virtual host configuration"
    
    # Allow .htaccess files to override settings
    echo "<Directory $Virtual_Host>
        AllowOverride All
    </Directory>" | sudo tee -a "$VHOST_FILE" > /dev/null || handle_error "Failed to update Apache virtual host configuration"
fi

# Reload Apache to apply changes
sudo systemctl restart apache2 && sudo systemctl reload apache2 && echo 'Apache reloaded'|| handle_error "Failed to reload Apache"

clear

echo "Setup completed successfully"

echo "Now you need to run the SQL code from the repository:"

sleep 5

## If you haven't set a password yet, you can just press enter
sudo mysql -p

clear

# Schedule permissions reset after 10 minutes.
(sleep 600 && sudo chmod -R 755 /var/www/html/* &) && echo "You should be good to go :) " && echo "Permissions reset scheduled" || handle_error "Failed to schedule permissions reset"
