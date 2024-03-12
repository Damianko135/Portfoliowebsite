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

# Clone the Portfoliowebsite repository
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main 

# Move the docker-compose.yaml file to the home directory
sudo mv Portfoliowebsite/docker-compose.yaml ~/

# Start the Portfoliowebsite Docker containers in detached mode
cd ~/ && docker-compose up -d

# Copy the contents of the Index directory to ~/.Portfolio
sudo cp -r ~/Portfoliowebsite/Index/* ~/.Portfolio/

# Remove the Portfoliowebsite directory
sudo rm -rf ~/Portfoliowebsite

# Clone the BBB repository
cd ~/.Block_B && sudo git clone https://github.com/Damianko135/BBB.git

# Move the contents of the BBB/public directory to ~/.Block_B
sudo mv ~/.Block_B/BBB/public/* ~/.Block_B/

# Remove the BBB directory
sudo rm -rf ~/.Block_B/BBB


docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest