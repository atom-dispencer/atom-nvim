#!/bin/bash
sudo apt-get update

#
# Install Oh My Bash
#

# Remove old configuration
rm ~/.oh-my-bash/ -r
rm ~/.bashrc
rm ~/.bash_profile

# Installation remakes its files
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
cp --remove-destination ../template.bashrc ~/.bashrc
