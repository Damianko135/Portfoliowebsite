#!/bin/bash

# Check if run as root
if [ $EUID != 0 ]; then
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

    # Convert to lowercase for case-insensitive comparison
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

# Proceed with other setup steps...


# Update and upgrade packages
echo "Updating and upgrading packages..."
apt-get update
apt-get full-upgrade -y
apt-mark showhold | xargs apt-get install -y --allow-change-held-packages
sleep 5

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh
sleep 5

# Install Docker Compose
echo "Installing Docker Compose..."
VERSION=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | jq -r .tag_name)
curl -fsSL "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sleep 5

# Install Git
echo "Installing Git..."
apt-get install -y git
sleep 5

# Enable Docker service
echo "Enabling Docker service..."
systemctl enable docker
systemctl start docker || { echo "Docker service failed to start. Exiting."; exit 1; }
sleep 5

# Setup cron job for auto-update at midnight
echo "Setting up cron job for auto-update..."
echo "0 0 * * * cd $(pwd) && docker-compose down --remove-orphans && docker-compose pull && docker-compose up --force-recreate --build -d && docker image prune -f" > /etc/cron.d/docker-autoupdate
sleep 5

mkdir -p ~/Portfolio ~/Link-Generator ~/sql-files

# Clone and setup Portfoliowebsite
echo "Cloning and setting up Portfoliowebsite..."
cd ~/
git clone https://github.com/Damianko135/Portfoliowebsite.git --single-branch -b main
mv Portfoliowebsite/docker-compose.yml ~/
mv -rf ~/Portfoliowebsite/Index/* ~/Portfolio/
rm -rf ~/Portfoliowebsite
sleep 5

# Clone first project
echo "Cloning first project..."
cd ~/Link-Generator
git clone https://github.com/Damianko135/Links.git
mv Links/* ~/Link-Generator
mv Links/.??* ~/Link-Generator
mv Scripts/Link-gen ~/sql-files
sleep 5

# Clone and setup BBB
echo "Cloning and setting up BBB..."
mkdir -p ~/Block_B
cd ~/Block_B
git clone https://github.com/Damianko135/BBB.git
mv BBB/* ~/Block_B/
rm -rf ~/Block_B/BBB
sleep 5

# Start up the containers
echo "Starting up the containers:"
cd ~/ && docker-compose up -d
sleep 5

# Install Portainer for Docker management
echo "Installing Portainer for Docker management..."
docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
sleep 5

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
echo "PPS: Don't forget to update the .env file"
echo " "
cat ~/.env
