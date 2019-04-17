#!/bin/sh
# Install build essentials
sudo apt update
sudo apt-get install -y build-essential

# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo apt -y install docker-compose

sudo usermod -a -G docker $USER
echo "Need to log our and log in again to take effect"

# Install Node v8
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install -y nodejs

# Install pm2
npm i -g pm2 composer-cli composer-playground

# Install Python 2
sudo apt-get install -y python
pip install glances

# Install nginx
sudo apt install -y nginx

# Github credentials caching for approx 1 year
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=31000000'

# Finally clone the hypervault repo
git clone https://github.com/lixiii/hypervault
cd hypervault 
git submodule init
git submodule update
git submodule sync
cd hypervault-rest-server
git submodule init
git submodule update
git submodule sync 
cd composer-rest-server/docker/
source build.sh
cd ../../
source rebuild.sh
cd ../../
source restart.sh

