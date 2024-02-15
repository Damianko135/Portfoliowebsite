#!/bin/bash

# Function to handle errors

# Change the variables accordingly
destination_dir="/var/www/html"
virtual_host="/var/www/html/Index"
branch="main"  # Change this to your desired branch
github_repo="https://github.com/Damianko135/Portfoliowebsite.git"
directory="Index"  # Change this to the directory you want to pull

# Update system packages and upgrade kept back packages
sudo apt update || handle_error "Failed to update system packages"
sudo apt full-upgrade -y || handle_error "Failed to upgrade system packages" 
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages || handle_error "Failed to upgrade held back packages"

# Install necessary packages: curl, Apache, firewall, MySQL, PHP, Git
sudo apt install curl apache2 ufw mysql-server php libapache2-mod-php php-mysql git -y || handle_error "Failed to install necessary packages"

# Allow SSH and Apache through the firewall
sudo ufw allow 'OpenSSH' || handle_error "Failed to allow SSH through firewall"
sudo ufw allow "Apache Full" || handle_error "Failed to allow Apache through firewall"
sudo a2enmod rewrite || handle_error "Failed to enable Apache rewrite module"

# Remove existing HTML directory
if [ -d "$destination_dir" ]; then
    sudo rm -rf "$destination_dir" || handle_error "Failed to remove existing HTML directory"
fi

# Create HTML directory and set permissions
sudo mkdir -p "$destination_dir" || handle_error "Failed to create HTML directory"
sudo chown -R "$(whoami)":"$(whoami)" "$destination_dir" || handle_error "Failed to set ownership for HTML directory"
sudo chmod -R 755 "$destination_dir" || handle_error "Failed to set permissions for HTML directory"

# Clone or update the repository
cd "$destination_dir" || handle_error "Failed to navigate to destination directory"
if [ ! -d ".git" ]; then
    # Clone the repository if it doesn't exist
    sudo git clone -b "$branch" --single-branch "$github_repo" "$directory" || handle_error "Failed to clone repository"
else
    sudo git -C "$directory" fetch origin "$branch" || handle_error "Failed to fetch updates from repository"
fi

## Edit Apache Virtual Host Configuration
# This section updates the Apache virtual host configuration to point to the correct directory.
VHOST_FILE="/etc/apache2/sites-available/000-default.conf"

# Backup the original configuration file if not already backed up
if [ ! -f "${VHOST_FILE}.bak" ]; then
    sudo cp "$VHOST_FILE" "${VHOST_FILE}.bak" || handle_error "Failed to backup Apache virtual host configuration"
    
    # Set the document root to the destination directory
    sudo sed -i "s#DocumentRoot /var/www/html#DocumentRoot $virtual_host#" "$VHOST_FILE" || handle_error "Failed to update Apache virtual host configuration"
    
    # Allow .htaccess files to override settings
    echo "<Directory $virtual_host>
        AllowOverride All
    </Directory>" | sudo tee -a "$VHOST_FILE" > /dev/null || handle_error "Failed to update Apache virtual host configuration"
fi

# Reload Apache to apply changes
sudo systemctl reload apache2 || handle_error "Failed to reload Apache"

# Check if Connection.php exists in the specified path
destination_file="$destination_dir/Index/Pages/Project_1/Scripts/Connection.php"
source_file="$destination_dir/Connection.php"
if [ ! -f "$destination_file" ] || ! cmp -s "$source_file" "$destination_file"; then
#     # Debugging output
#     echo "Source file: $source_file"
#     echo "Destination file: $destination_file"
#     cmp -s "$source_file" "$destination_file"
    
    # Copy Connection.php to the specified path
    if sudo rsync -a --ignore-existing "$source_file" "$destination_file"; then
        clear
        (sudo rm -rf "$source_file" && sudo nano "$destination_file" )|| echo "You can still alter the credentials at $destination_file"
        echo "Connection.php copied successfully."
        echo "You can manually edit the Connection.php file in $destination_dir/Index/Pages/Project_1/Scripts/ to provide the proper credentials."
    else
        handle_error "Failed to copy Connection.php"
    fi
else
    echo "Connection.php already exists and is identical. Skipping copy."
fi

# Success message
echo "Setup completed successfully"

# Prompt for MySQL password setup
echo "Now you need to run the SQL code from the repository:"
echo "If you haven't set a password yet, you can just press enter"
echo "And use this to set a password: ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';"
sudo mysql -p
sleep 5
handle_error() {
    local error_message="$1"
    echo "Error: $error_message" >&2
}

# Schedule permissions reset after 10 minutes.
(sleep 600 && sudo chmod -R 755 "$destination_dir" &) && echo "You should be good to go :) " && echo "Permissions reset scheduled" || handle_error "Failed to schedule permissions reset"
