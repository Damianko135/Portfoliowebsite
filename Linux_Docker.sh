#!/bin/bash

## First, Update everything
sudo apt update 
sudo apt full-upgrade -y
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages 

## If you also use a Cloudflare Tunnel, copy the docker code underneath here. it might take a minute, but it'll work
# Dont forget a -d, do not specify a port for the Tunnel. Thats is why mine didn't work.



## Clone GitHub repository, in this case mine
# I cant clone the index, otherwise i would've said Index behind it.
# The reason i cant do that is that otherwise it doesnt clone the docker-compose.yml file with it.
git clone main --single-branch https://github.com/Damianko135/Portfoliowebsite.git Index






