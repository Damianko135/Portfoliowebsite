#!/bin/bash

# Destination directory where you want to place the files
destination_dir="/var/www/html"

# Branch and directory within the repository to pull
branch="Website"  # Change this to your desired branch
directory="public"  # Change this to the directory you want to pull

# Check if the destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
fi

# Navigate to the destination directory
cd "$destination_dir" || exit

# Clone or update the repository
if [ ! -d "BBB" ]; then
    # Clone the repository if it doesn't exist
    git clone -b "$branch" --single-branch https://github.com/Gamelink2/BBB.git
else
    # Navigate into the existing repository directory
    cd BBB || exit

    # Update the existing repository
    git fetch origin "$branch"
    git reset --hard "origin/$branch"
    git clean -df
fi

