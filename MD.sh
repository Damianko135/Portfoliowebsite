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
sudo apt install git -y

# Check if the destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    sudo mkdir -p "$destination_dir" || handle_error "Failed to create destination directory"
fi

# Navigate to the destination directory
cd "$destination_dir" || handle_error "Failed to navigate to destination directory"

# Clone or update the repository
if [ ! -d ".git" ]; then
    # Clone the repository if it doesn't exist
    sudo git clone -b "$branch" --single-branch "$github_repo" . || handle_error "Failed to clone repository"
else
    # Update the existing repository
    sudo git fetch origin "$branch" || handle_error "Failed to fetch updates from repository"
fi

sudo bash /var/www/html/Linux_Setup.sh