#!/bin/bash

set -e  # exit whenever a command failed

# install basic programs
sudo apt update && sudo apt upgrade
sudo apt install curl wget zsh git vim

# config files
cp ./.vimrc ./.zshrc ~

# git
git config --global user.email "vailgrass@gmail.com"
git config --global user.name "Hangyu Feng"

# zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L git.io/antigen > antigen.zsh  # zsh package manager
chsh -s $(which zsh) && zsh
source ~/.zshrc

# vim setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

