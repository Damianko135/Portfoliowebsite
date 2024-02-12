# Portfolio Website

Welcome to my portfolio website repository! This website showcases my projects, skills, and experiences.

## Features

- <span style="font-weight:bold; color:#3399ff;">Projects</span>: Explore my latest projects and contributions.
- <span style="font-style:italic; color:#ff3333;">Skills</span>: Learn about my technical skills and expertise.
- <span style="font-weight:bold; color:#00cc66; font-family:'Comic Sans MS', cursive, sans-serif;">Experience</span>: Discover my professional experience and achievements.

## Getting Started

To run this website locally on your device, follow these steps:

### Prerequisites

Ensure that you have the following software installed on your system:

- **Node.js**: v12.0.0 or higher
- **npm**: v6.0.0 or higher
- **React**: v17.0.0 or higher
- **MySQL**: v5.7 or higher

## Setup Scripts for Linux and Windows

You can set up the website on both Linux and Windows servers. Choose the appropriate setup script based on your system:

### Linux Setup

If you are using a Linux server, run the following commands:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/Damianko135/Portfoliowebsite.git
    ```

2. Navigate to the project directory:

    ```bash
    cd Portfoliowebsite
    ```

3. Run the setup script:

    ```bash
    bash Linux_Setup.sh
    ```

4. After the setup script completes, open a web browser and visit `http://localhost:3000` to view the website.

### Windows Setup

For Windows servers, execute the following steps:

1. Clone this repository to your local machine:

    ```powershell
    git clone https://github.com/Damianko135/Portfoliowebsite.git
    ```

2. Navigate to the project directory:

    ```powershell
    cd Portfoliowebsite
    ```

3. Run the setup script:

    ```powershell
    .\Windows_Setup.ps1
    ```

4. After the setup script completes, open a web browser and visit `http://localhost:3000` to view the website.

## Uninstallation Scripts

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
