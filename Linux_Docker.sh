#!/bin/bash

# Check if run as root
if [ $EUID -ne 0 ]; then
    echo "Please run as root"
    echo "sudo su to change to root user"
    exit 1
fi

# Define the log file
LOGFILE=$(mktemp ~/setup-log.XXXXXX)

# Redirect stdout and stderr to the log file
exec > >(tee -a "$LOGFILE") 2>&1

clear
echo "----- "
echo " "
echo " "
echo " "
echo "Setting up environment variables..."

# Check if .env file exists
if [ ! -f ~/.env ]; then
    # Prompt user for variables
    echo "Please provide the following variables:"
    read -t 10 -p "Cloudflare token (can be left empty for now): " TUNNEL_TOKEN
    read -t 10 -p "Do you want the MySQL database to be available without a password? (Y/n): " EMPTY_PW

    # Default behavior if no input is given (timeout)
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

    shopt -s dotglob

    # Write variables to .env file
    echo "Generating .env file..."
    cat <<EOF > ~/.env
## Example .env file
TUNNEL_TOKEN="$TUNNEL_TOKEN"
MYSQL_ALLOW_EMPTY_PASSWORD="$EMPTY_PW"
EOF

    sleep 5
else
    echo ".env file already exists. Skipping variable setup."
fi

# Update and upgrade packages
echo "Updating and upgrading packages..."
apt-get update
apt-get full-upgrade -y
apt-mark showhold | xargs apt-get install -y --allow-change-held-packages
sleep 5

# Install Docker if not already installed
if [ ! -x "$(command -v docker)" ]; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm -f get-docker.sh
    sleep 5
else
    echo "Docker is already installed."
fi

# Install Docker Compose if not already installed
if [ ! -x "$(command -v docker-compose)" ]; then
    echo "Installing Docker Compose..."
    LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    curl -fsSL https://github.com/docker/compose/releases/download/$LATEST_VERSION/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sleep 5
else
    echo "Docker Compose is already installed."
fi

# Install Git if not already installed
if [ ! -x "$(command -v git)" ]; then
    echo "Installing Git..."
    apt-get install -y git
    sleep 5
else
    echo "Git is already installed."
fi

# Enable Docker service
echo "Enabling Docker service..."
systemctl enable docker
sleep 5

# Setup cron job for auto-update at midnight
echo "Setting up cron job for auto-update..."
crontab -l 2>/dev/null | { cat; echo "0 0 * * * cd $(pwd) && docker-compose down --remove-orphans && docker-compose pull && docker-compose up --force-recreate --build -d && docker image prune -f"; } | crontab -
sleep 5

mkdir -p ~/sql-files

# Clone and setup Portfoliowebsite
echo "Cloning and setting up Portfoliowebsite..."
PORTFOLIO_DIR=~/Portfoliowebsite
if [ -d "$PORTFOLIO_DIR" ]; then
    echo "$PORTFOLIO_DIR already exists. Moving it to a backup location."
    mv "$PORTFOLIO_DIR" "${PORTFOLIO_DIR}_backup"
fi
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main
rm -rf ~/Portfolio
mv ~/Portfoliowebsite/docker-compose.yml ~/
mv ~/Portfoliowebsite/Index/* ~/Portfolio/
rm -rf ~/Portfoliowebsite
sleep 5

# Clone first project
echo "Cloning first project..."
mkdir ~/Link-Generator && cd ~/Link-Generator
git clone https://github.com/Damianko135/Links.git
if [ -d "Links" ]; then
    mv Links/* ~/Link-Generator
fi
if [ -d "Links/Scripts/Link-gen" ]; then
    mv Links/Scripts/Link-gen ~/sql-files
else
    echo "Scripts/Link-gen not found."
fi
sleep 5

# Clone and setup BBB
echo "Cloning and setting up BBB..."
mkdir -p ~/Block_B && cd ~/Block_B
git clone https://github.com/Damianko135/BBB.git
mv ~/Block_B/BBB/* ~/Block_B/
rm -rf ~/Block_B/BBB
sleep 5

# Start up the containers
echo "Starting up the containers:"
cd ~/ && docker-compose up -d
sleep 5

# Check if Portainer is already running
echo "Checking if Portainer is already running..."
if docker ps -q -f name=portainer > /dev/null; then
    echo "Portainer is already running."
else
    echo "Portainer is not running. Checking if it exists..."
    if docker ps -aq -f name=portainer > /dev/null; then
        echo "Portainer container exists but is not running. Starting the container..."
        docker start portainer
    else
        echo "Portainer container does not exist. Creating and starting a new container..."
        docker run -d \
            -p 9000:9000 \
            --name portainer \
            --restart always \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v portainer_data:/data \
            portainer/portainer-ce:latest
    fi
fi

shopt -u dotglob

echo "Setup complete."

sleep 5

clear
echo "----- "
echo " "
echo " "
echo " "
echo "Completed, have fun! "
echo "Ps. Check the docker-compose file for the ports which are in use"
echo "Full log: $LOGFILE"
echo "PPS: Dont forget to update the .env file"
echo " "
cat ~/.env
