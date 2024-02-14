# Uninstall Chocolatey packages
Write-Host "Uninstalling Chocolatey packages..."
choco uninstall apache2 mysql-server php libapache2-mod-php git -y

# Uninstall Git
Write-Host "Uninstalling Git..."
choco uninstall git -y

# Uninstall Chocolatey
Write-Host "Uninstalling Chocolatey..."
choco uninstall chocolatey -y
