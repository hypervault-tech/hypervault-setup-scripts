#!/bin/sh
# Install build essentials
sudo apt update
sudo apt-get install -y build-essential

# Install zsh
sudo apt install -y zsh
sudo apt-get install -y powerline fonts-powerline
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# sudo chsh -s /bin/zsh


# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo apt install -y docker-compose

sudo usermod -a -G docker $USER
echo "Need to log our and log in again to take effect"

# Install Node v8
# curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
# sudo apt install -y nodejs

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
bash
nvm install 8.9.4

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

# Setup aliases
ALIASES='
# Prints docker containers in paged mode
alias dps="docker ps | less -S"
alias tls="tmux list-session"
alias tks="tmux kill-session -t "
alias tns="tmux new -s "
alias tat="tmux attach -t"
'

echo "Setting up the following aliases"
echo "$ALIASES"
echo "$ALIASES" > ~/.bash_aliases

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