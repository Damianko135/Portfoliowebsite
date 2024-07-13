#!/bin/bash

## Allow. files, such as.htaccess to also be moved
shopt -s dotglob

## To make sure the commands will be executed correctly.
cd ~/

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt full-upgrade -y

# Install any held packages
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages 

# Install Docker, Docker Compose, and Git
curl -fsSL https://get.docker.com/ | sh

sudo apt install docker-compose git -y

# Remove unnecessary packages
sudo apt autoremove -y

# Clean up package cache
sudo apt autoclean

# Enable Docker service
sudo systemctl enable docker

# Clone the Portfoliowebsite repository
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main 

# Move the docker-compose.yml file to the home directory
sudo mv Portfoliowebsite/docker-compose.yml ~/

touch.env
echo "## You dont need an actual token, but do remember, it will fail to start.
TUNNEL_TOKEN= " >>./.env
echo "MYSQL_ALLOW_AMPTY_PASSWORD=" >>./.env

# Start the Portfoliowebsite Docker containers in detached mode
cd ~/ && docker-compose up -d

# Copy the contents of the Index directory to ~/.Portfolio
sudo cp -rf ~/Portfoliowebsite/Index/* ~/.Portfolio/
sudo cp -rf ~/Portfoliowebsite/Database/* ~/sql-files/

# Remove the Portfoliowebsite directory
sudo rm -rf ~/Portfoliowebsite

# Clone the BBB repository
cd ~/.Block_B && sudo git clone https://github.com/Damianko135/BBB.git

# Move the contents of the BBB/public directory to ~/.Block_B
sudo mv ~/.Block_B/BBB/public/* ~/.Block_B/

# Remove the BBB directory
sudo rm -rf ~/.Block_B/BBB

# Very nice to have this for seeing the status of all containers.
docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest