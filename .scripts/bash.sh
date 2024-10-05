#!/bin/bash
sudo apt-get update

# Make a symlink to point to my dotfile
rm ~/.bashrc
ln -s ~/.dotfiles/.bashrc ~/.bashrc

