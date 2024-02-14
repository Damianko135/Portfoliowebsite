#!/bin/bash

# Change the variables accordingly
destination_dir="/var/www/html/"
Virtual_Host="/var/www/html/Index"
branch="main"  # Change this to your desired branch
github_repo="https://github.com/Damianko135/Portfoliowebsite.git"
directory="Index"  # Change this to the directory you want to pull

# Function to handle errors


# Update system packages and upgrade kept back packages
sudo apt update || echo "Failed to update system packages"x
sudo apt install git -y

sudo rm -rf "$destination_dir"

sudo mkdir -p "$destination_dir" || echo "Failed to create destination directory"

cd "$destination_dir" || echo "Failed to navigate to destination directory"

sudo git clone -b "$branch" --single-branch "$github_repo" . || echo "Failed to clone repository"


sudo bash /var/www/html/Linux_Setup.sh