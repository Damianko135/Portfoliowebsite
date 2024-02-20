#!/bin/bash

## First, Update everything
sudo apt update 
sudo apt full-upgrade -y
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages 

sudo apt purge containerd.io
sudo apt autoremove
sudo apt autoclean
sudo apt update
sudo apt install docker.io docker-compose
sudo systemctl enable docker


