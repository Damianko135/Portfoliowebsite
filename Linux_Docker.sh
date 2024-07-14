#!/bin/bash

set -e

# Check if run as root.
if [ $EUID != 0 ]; then
    echo "Please run as root"
    exit 1
fi

clear
echo "----- "
echo " "
echo " "
echo " "
echo "Setting up environment variables..."

# Prompt user for variables
echo "Please provide the required variables:"
read -p "Cloudflare token (leave empty for now): " TUNNEL_TOKEN

read -p "Do you want the MySQL database to be available without a password? (Y/n): " EMPTY_PW
if [[ "$EMPTY_PW" == "N" || "$EMPTY_PW" == "n" ]]; then
  echo "You will need to set a password on first login."
else
  echo "CAUTION: Using MySQL without a password is not recommended for production."
  EMPTY_PW="yes"
  await 10
fi

# Write variables to .env file
echo "Generating .env file..."
cat <<EOF > ~/.env
## Example .env file
TUNNEL_TOKEN="$TUNNEL_TOKEN"
MYSQL_ALLOW_EMPTY_PASSWORD="$EMPTY_PW"
EOF

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh

# Install Docker Compose
echo "Installing Docker Compose..."
curl -fsSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Git
echo "Installing Git..."
apt-get update
apt-get install -y git

# Clone and setup Portfoliowebsite
echo "Cloning and setting up Portfoliowebsite..."
cd ~/
<<<<<<< Updated upstream

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
=======
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main
mv Portfoliowebsite/docker-compose.yml ~/
>>>>>>> Stashed changes
cd ~/ && docker-compose up -d
cp -rf ~/Portfoliowebsite/Index/* ~/.Portfolio/
cp -rf ~/Portfoliowebsite/Database/* ~/sql-files/
rm -rf ~/Portfoliowebsite

# Clone and setup BBB
echo "Cloning and setting up BBB..."
mkdir -p ~/.Block_B && cd ~/.Block_B
git clone https://github.com/Damianko135/BBB.git
mv ~/.Block_B/BBB/public/* ~/.Block_B/
rm -rf ~/.Block_B/BBB

# Install Portainer for Docker management
echo "Installing Portainer for Docker management..."
docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

echo "Setup complete."
