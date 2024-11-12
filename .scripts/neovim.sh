#!/bin/bash

# Clone configuration
mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Neovim itself
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt-get -y install neovim

# Core dependencies
sudo apt-get -y install gcc             # To self compile basically anything
sudo apt-get -y install python3         # Because python is everywhere
sudo apt-get -y install python3-venv
sudo apt-get -y install unzip           # For many mason packages
sudo apt-get -y install luarocks        # Needed for lua language server
sudo apt-get -y install npm             # Needed for some mason packages (incl matlab)
