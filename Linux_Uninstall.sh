#!/bin/bash

# Function to handle errors
handle_error() {
    local error_message="$1"
    echo "Error: $error_message" >&2
    exit 1
}

# Undo Apache virtual host configuration changes
VHOST_FILE="/etc/apache2/sites-available/000-default.conf"
if [ -f "${VHOST_FILE}.bak" ]; then
    sudo cp "${VHOST_FILE}.bak" "$VHOST_FILE" || handle_error "Failed to restore Apache virtual host configuration"
    sudo rm -rf "${VHOST_FILE}.bak" || handle_error "Failed to remove backup of Apache virtual host configuration"
fi

# Restart Apache to apply changes
sudo systemctl restart apache2 && echo 'Apache restarted' || handle_error "Failed to restart Apache"
sudo apt remove --purge apache2 mysql-server php libapache2-mod-php php-mysql -y || handle_error "Failed to uninstall packages"

# Remove destination directory

# Uninstall installed packages

# Revert firewall rules
sudo ufw delete allow "Apache Full" || handle_error "Failed to revert Apache firewall rule"
sudo rm -rf /var/www/html/ || handle_error "Failed to remove destination directory"

sudo apt autoremove -y
sudo apt autoclean -y

cd ..

clear 

sudo rm -rf Portfoliowebsite


echo "Removed the scripts"

echo "Reversion completed successfully"
