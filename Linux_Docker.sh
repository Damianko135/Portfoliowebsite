#!/bin/bash

# Check if run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root. Use sudo su to change to root user."
    exit 1
fi

# Define the log file
LOGFILE=$(mktemp ~/setup-log.XXXXXX)
exec > >(tee -a "$LOGFILE") 2>&1

clear
echo "----- Setting up environment variables..."

# Handle .env file
ENV_FILE=~/.env
if [ ! -f "$ENV_FILE" ]; then
    echo "Please provide the following variables:"
    read -t 10 -p "Cloudflare token (can be left empty for now): " TUNNEL_TOKEN
    read -t 10 -p "Do you want the MySQL database to be available without a password? (Y/n): " EMPTY_PW

    EMPTY_PW=${EMPTY_PW:-"y"}
    EMPTY_PW=$(echo "$EMPTY_PW" | tr '[:upper:]' '[:lower:]')

    if [[ "$EMPTY_PW" == "n" ]]; then
        echo "You will need to set a password on first login."
        EMPTY_PW="no"
    else
        echo "CAUTION: Using MySQL without a password is not recommended for production."
        EMPTY_PW="yes"
        sleep 10
    fi

    # Create .env file
    echo "Generating .env file..."
    cat <<EOF > "$ENV_FILE"
## Example .env file
TUNNEL_TOKEN="$TUNNEL_TOKEN"
MYSQL_ALLOW_EMPTY_PASSWORD="$EMPTY_PW"
EOF
else
    echo ".env file already exists. Skipping variable setup."
fi

# Update and upgrade packages
echo "Updating and upgrading packages..."
apt-get update && apt-get full-upgrade -y
apt-mark showhold | xargs apt-get install -y --allow-change-held-packages

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm -f get-docker.sh
else
    echo "Docker is already installed."
fi

# Install Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    curl -fsSL https://github.com/docker/compose/releases/download/$LATEST_VERSION/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed."
fi

# Install Git
if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    apt-get install -y git
else
    echo "Git is already installed."
fi

# Enable Docker service
echo "Enabling Docker service..."
systemctl enable docker

# Setup cron job
echo "Setting up cron job for auto-update..."
crontab -l 2>/dev/null | { cat; echo "0 0 * * * cd $(pwd) && docker-compose down --remove-orphans && docker-compose pull && docker-compose up --force-recreate --build -d && docker image prune -f"; } | crontab -

# Clone and setup Portfoliowebsite
echo "Cloning and setting up Portfoliowebsite..."
PORTFOLIO_DIR=~/Portfoliowebsite
if [ -d "$PORTFOLIO_DIR" ]; then
    echo "$PORTFOLIO_DIR already exists. Moving it to a backup location."
    mv "$PORTFOLIO_DIR" "${PORTFOLIO_DIR}_backup"
fi
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main

# Move files to their locations
mv ~/Portfoliowebsite/docker-compose.yml ~/
mkdir -p ~/Portfolio
mv ~/Portfoliowebsite/Index/* ~/Portfolio/
rm -rf ~/Portfoliowebsite

# Clone first project
echo "Cloning first project..."
mkdir -p ~/Link-Generator && cd ~/Link-Generator
git clone https://github.com/Damianko135/Links.git
mv Links/* ~/Link-Generator
rm -rf Links

# Clone and setup BBB
echo "Cloning and setting up BBB..."
mkdir -p ~/Block_B && cd ~/Block_B
git clone https://github.com/Damianko135/BBB.git
mv BBB/* ~/Block_B/
rm -rf BBB

# Start containers
echo "Starting up the containers:"
cd ~/ && docker-compose up -d

# Manage Portainer
echo "Checking Portainer..."
if ! docker ps -q -f name=portainer &> /dev/null; then
    if docker ps -aq -f name=portainer &> /dev/null; then
        echo "Portainer container exists but is not running. Starting it..."
        docker start portainer
    else
        echo "Portainer container does not exist. Creating and starting it..."
        docker run -d \
            -p 9000:9000 \
            --name portainer \
            --restart always \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v portainer_data:/data \
            portainer/portainer-ce:latest
    fi
else
    echo "Portainer is already running."
fi

echo "Setup complete."
sleep 5
clear
echo "Completed, have fun!"
echo "Ps. Check the docker-compose file for the ports which are in use"
echo "Full log: $LOGFILE"
echo "PPS: Don't forget to update the .env file"
cat "$ENV_FILE"
