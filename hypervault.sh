#!/bin/sh
set -e
# Download the SSL Credentials
git clone https://github.com/lixiii/hypervault-server-credentials.git ~/credentials
# set hostname
sudo hostnamectl set-hostname fabric-endpoint
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