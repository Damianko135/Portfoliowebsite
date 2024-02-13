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
sudo apt update || handle_error "Failed to update system packages"x
sudo apt install git -y

# Check if the destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    sudo mkdir -p "$destination_dir" || handle_error "Failed to create destination directory"
fi

cd "$destination_dir" || handle_error "Failed to navigate to destination directory"

sudo git clone -b "$branch" --single-branch "$github_repo" . || handle_error "Failed to clone repository"


sudo bash /var/www/html/Linux_Setup.sh