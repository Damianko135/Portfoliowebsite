#!/bin/bash

# Check if run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root. Use su to change to root user."
    exit 1
fi

# Define the log file
LOGFILE=$(mktemp ~/setup-log.XXXXXX)
exec > >(tee -a "$LOGFILE") 2>&1

clear
echo "----- Setting up environment variables..."

# Handle .env file
if [ ! -f ~/.env ]; then
    echo "Please provide the following variables:"
    read -t 10 -p "Cloudflare token (can be left empty for now): " TUNNEL_TOKEN
    read -t 10 -p "Do you want the MySQL database to be available without a password? (Y/n): " EMPTY_PW

    EMPTY_PW=${EMPTY_PW:-"y"}
    EMPTY_PW=$(echo "$EMPTY_PW" | tr '[:upper:]' '[:lower:]')

    if [[ "$EMPTY_PW" == "n" ]]; then
        EMPTY_PW="no"
    else
        EMPTY_PW="yes"
        echo "CAUTION: Using MySQL without a password is not recommended for production."
        sleep 10
    fi

    echo "Generating .env file..."
    cat <<EOF > ~/.env
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
apt-mark showhold | xargs apt-get install -y --allow-change-held-packages || true

# Install Docker if not already installed
if ! command -v docker &> /dev/null || ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker and Docker Compose..."

    # Install necessary packages and tools
    echo "Installing dependencies..."
    apt-get install -y ca-certificates curl gnupg lsb-release || true

    # Add Docker's official GPG key
    echo "Adding Docker's GPG key..."
    mkdir -p /etc/apt/keyrings || true
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg || true

    # Set up the Docker repository
    echo "Setting up Docker repository..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null || true

    # Update package index
    echo "Updating package index..."
    apt-get update || true

    # Install Docker and Docker Compose
    echo "Installing Docker and Docker Compose..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || true

    # Add the current user to the Docker group
    echo "Adding user $USER to the Docker group..."
    usermod -aG docker $USER || true

    # Enable and start Docker service
    echo "Enabling Docker service..."
    systemctl enable docker || true
    echo "Starting Docker service..."
    systemctl start docker || true

    # Verify installation
    echo "Verifying Docker installation..."
    docker --version || true
    docker-compose --version || true

    echo "Docker installation completed successfully."
else
    echo "Docker is already installed."
fi

# Install Git if not already installed
if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    apt-get install -y git || true
else
    echo "Git is already installed."
fi

# Setup cron job
echo "Setting up cron job for auto-update..."
crontab -l 2>/dev/null | { cat; echo "0 0 * * * cd $(pwd) && docker-compose down --remove-orphans && docker-compose pull && docker-compose up --force-recreate --build -d && docker image prune -f"; } | crontab -

# Ensure sql-files directory exists
mkdir -p ~/sql-files

# Clone and setup Portfoliowebsite
echo "Cloning and setting up Portfoliowebsite..."
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main
mv ~/Portfoliowebsite/docker-compose.yml ~/
mkdir -p ~/Portfolio
mv ~/Portfoliowebsite/Index/* ~/Portfolio/
mkdir -p ~/sql-files
mv ~/Portfoliowebsite/*.sql ~/sql-files

# Clone first project
echo "Cloning first project..."
mkdir -p ~/Link-Generator && cd ~/Link-Generator
git clone https://github.com/Damianko135/Links.git
mv Links/*.sql ~/sql-files
mv Links/* ~/Link-Generator

# Clone and setup BBB
echo "Cloning and setting up BBB..."
mkdir -p ~/Block_B && cd ~/Block_B
git clone https://github.com/Damianko135/BBB.git
mv BBB/* ~/Block_B/

# Start containers
echo "Starting up the containers:"
cd ~/ && docker-compose up -d

# Manage Portainer
echo "Creating and starting Portainer container..."
docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

# Cleanup
echo "Cleaning up..."
cd ~/
rm -rf BBB
rm -rf Links
rm -rf ~/Portfoliowebsite

echo "Setup complete."
sleep 5
clear
echo "Completed, have fun!"
echo "Ps. Check the docker-compose file for the ports which are in use"
echo "Full log: $LOGFILE"
echo "PPS: Don't forget to update the .env file"
