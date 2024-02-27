#!/bin/bash

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt full-upgrade -y

# Install any held packages
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages 

# Install Docker, Docker Compose, and Git
sudo apt install docker.io docker-compose git -y

# Remove unnecessary packages
sudo apt autoremove -y

# Clean up package cache
sudo apt autoclean

# Enable Docker service
sudo systemctl enable docker

# Clone the repository
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main 

cd Portfoliowebsite

docker-compose up -d