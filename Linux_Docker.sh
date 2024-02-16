#!/bin/bash

## First, Update everything
sudo apt update 
sudo apt full-upgrade -y
sudo apt-mark showhold | xargs sudo apt install -y --allow-change-held-packages 

## Install so that you can actually pull stuff from github and make a container.. 
sudo apt install docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc git -y

## Create a place to store the information when you first open portainer
docker volume create portainer_data

## So you alway have an overview of your running containers, even is you compose down

docker run -d -p 9000:9000 --name Portainer --restart=always \
         -v /var/run/docker.sock:/var/run/docker.sock \
         -v portainer_data:/data portainer/portainer-ce:latest

## If you also use a Cloudflare Tunnel, copy the docker code underneath here. it might take a minute, but it'll work
# Dont forget a -d, do not specify a port for the Tunnel. Thats is why mine didn't work.



## Clone GitHub repository, in this case mine
# I cant clone the index, otherwise i would've said Index behind it.
# The reason i cant do that is that otherwise it doesnt clone the docker-compose.yml file with it.
git clone main --single-branch https://github.com/Damianko135/Portfoliowebsite.git

## Get into the repository that has been downloaded
cd Portfoliowebsite

## And Activate the docker-compose.yml to built the containers for the applications.
# I'm not far enough yet that i can use kubernetes. So i prefer to stick to the stuff I alreadt (partially) know
docker-compose up -d




