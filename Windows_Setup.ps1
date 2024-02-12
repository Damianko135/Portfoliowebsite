# PowerShell script for automating setup on a Windows server

# Define variables
$destinationDir = "C:\inetpub\wwwroot\Index"
$branch = "main"
$githubRepo = "https://github.com/Damianko135/Portfoliowebsite.git"

# Function to install Chocolatey
function InstallChocolatey {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Function to install Git
function InstallGit {
    Write-Host "Installing Git..."
    choco install git -y
}

# Function to clone or update the repository
function CloneOrUpdateRepository {
    Write-Host "Cloning or updating the repository..."
    if (Test-Path -Path "$destinationDir\.git") {
        # Update existing repository
        Set-Location -Path $destinationDir
        git fetch origin $branch
        git reset --hard "origin/$branch"
        git clean -df
    } else {
        # Clone the repository if it doesn't exist
        git clone -b $branch --single-branch $githubRepo $destinationDir
    }
}

# Function to install necessary packages
function InstallPackages {
    Write-Host "Installing necessary packages..."
    choco install apache2 mysql-server php libapache2-mod-php -y
}

# Function to configure firewall
function ConfigureFirewall {
    Write-Host "Configuring firewall..."
    # Add commands to allow SSH and Apache through the firewall
    # Example:
    # New-NetFirewallRule -DisplayName "Allow SSH" -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow
    # New-NetFirewallRule -DisplayName "Allow Apache" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
}

# Function to adjust permissions for the default directory
function AdjustPermissions {
    Write-Host "Adjusting permissions for default directory..."
    # Add commands to create directory and adjust permissions
    # Example:
    # New-Item -Path C:\inetpub\wwwroot -ItemType Directory
    # Set-Item -Path C:\inetpub\wwwroot -Recurse -Force -Include *.* -Permission "IIS_IUSRS":"Modify"
}

# Main script execution
try {
    # Install Chocolatey
    InstallChocolatey

    # Install Git
    InstallGit

    # Clone or update the repository
    CloneOrUpdateRepository

    # Install necessary packages
    InstallPackages

    # Configure firewall
    ConfigureFirewall

    # Adjust permissions for default directory
    AdjustPermissions

    Write-Host "Setup completed successfully."
} catch {
    Write-Host "Error occurred: $_"
}
