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

- For now, only automated with Linux, apt as package manager.
- Script installs required packages.

## Setup Script

You can set up the website on Linux based systems.

### Linux Setup

1. Clone this repository to your local machine:

    ```bash
    git clone -b main --single-branch https://github.com/Damianko135/Portfoliowebsite.git || echo "Failed to clone repository"
    ```

2. Run the setup script from the cloned directory:
    *Only works with apt*
    ```bash
    bash Portfoliowebsite/Linux_Docker.sh || (sudo dpkg --configure -a && bash Portfoliowebsite/Linux_Docker.sh)
    ```



## Customization

- **Branch**: You can change the branch used by the setup script by modifying the `branch` variable.
- **Directory**: Adjust the `directory` variable in the setup script to specify the directory you want to pull.

## Contributing

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Updating:

To keep everything up to date, the script is initiating a cronjob using the following commands `docker-compose down --remove-orphans docker-compose pull && docker-compose up --force-recreate --build -d && docker image prune -f`.
