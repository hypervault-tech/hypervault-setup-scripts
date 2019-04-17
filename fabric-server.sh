#!/bin/sh
set -e

# Install build essentials
sudo apt-get update -qq > /dev/null
sudo apt-get install -y -qq build-essential 

# Install zsh
sudo apt-get install -y -qq zsh > /dev/null
sudo apt-get install -y -qq powerline fonts-powerline > /dev/null
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# sudo chsh -s /bin/zsh


# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo apt-get install -y -qq docker-compose > /dev/null

sudo usermod -a -G docker $USER
echo "Need to log our and log in again to take effect"

# Install Node v8
# curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
# sudo apt-get install -y -qq nodejs> /dev/null

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Python 2
sudo apt-get install -y -qq python 
pip install glances 

# Install nginx
sudo apt-get install -y -qq nginx > /dev/null

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

# Finally prompt user to log out and log in again to run hypervault.sh
wget -O hypervault.sh https://raw.githubusercontent.com/lixiii/hypervault-setup-scripts/master/hypervault.sh
echo "Logging you out. Please login again to run hypervault.sh"
exit