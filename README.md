# Portfolio Website

Welcome to my portfolio website repository! This website showcases my projects, skills, and experiences.

## Features

- **Projects**: Explore my latest projects and contributions.
- **Skills**: Learn about my technical skills and expertise.
- **Experience**: Discover my professional experience and achievements.

## Getting Started

To run this website locally on your device, follow these steps:

### Prerequisites

Ensure that you have the following software installed on your system:

- **Node.js**: v12.0.0 or higher
- **npm**: v6.0.0 or higher
- **React**: v17.0.0 or higher
- **MySQL**: v5.7 or higher

## Setup Script

You can set up the website on both Linux and Windows servers using the provided setup script.

### Linux Setup

1. Clone this repository to your local machine:

    ```bash
    git clone -b Bash_Script --single-branch https://github.com/Damianko135/Portfoliowebsite.git || echo "Failed to clone repository"
    ```

2. Run the setup script from the cloned directory:

    ```bash
    bash Portfoliowebsite/Linux_Setup.sh || (sudo dpkg --configure -a && bash Portfoliowebsite/Linux_Setup.sh)
    ```

3. After the setup script completes, open a web browser and visit `http://localhost:3000` to view the website.

### Windows Setup

1. Clone this repository to your local machine:

    ```powershell
    git clone -b Bash_Script --single-branch https://github.com/Damianko135/Portfoliowebsite.git || echo "Failed to clone repository"
    ```

2. Run the setup script from the cloned directory:

    ```powershell
    cd Portfoliowebsite
    .\Windows_Setup.ps1
    ```

3. After the setup script completes, open a web browser and visit `http://localhost:3000` to view the website.

### Uninstallation Scripts

To uninstall the packages installed by the setup scripts and remove any associated software, you can use the provided uninstallation scripts:

- **Linux**: Execute the `Linux_Uninstall.sh` script.
- **Windows**: Run the `Windows_Uninstall.ps1` script.

## Customization

- **Branch**: You can change the branch used by the setup script by modifying the `branch` variable.
- **Directory**: Adjust the `directory` variable in the setup script to specify the directory you want to pull.

## Contributing

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
