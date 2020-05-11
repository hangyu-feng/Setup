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
chsh -s $(which zsh)
if [[ ! $SHELL =~ zsh ]]; then
  echo "zsh version:"
  zsh --version
  echo "either zsh isn't installed or isn't set as default"
  exit 1
fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L git.io/antigen > antigen.zsh  # zsh package manager
source ~/.zshrc

# vim setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

