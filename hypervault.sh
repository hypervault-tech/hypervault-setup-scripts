#!/bin/sh
set -e
# Download the SSL Credentials first to save the github credentials
git clone https://github.com/lixiii/hypervault-server-credentials.git ~/credentials
# set hostname
sudo hostnamectl set-hostname fabric-endpoint

# use node 8.9.4 and install composer dependencies
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm and makes it available
nvm install 8.9.4 
npm i -g pm2 composer-cli composer-playground 

git clone https://github.com/lixiii/hypervault
cd hypervault 
npm i commander

# update and install all submodules
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
cd ../../dev-tools/
source ./restartHypervault.sh

# source restart.sh