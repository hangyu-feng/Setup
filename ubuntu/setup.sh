#!/bin/bash

set -e  # exit whenever a command failed

# install basic programs
sudo apt update && sudo apt upgrade
sudo apt install curl wget zsh git vim-gtk3  # vim-gtk3 provides extended features like clipboard for ubuntu

# config files
cp ./.vimrc ./.zshrc ~
cd ~

# git
git config --global user.email "vailgrass@gmail.com"
git config --global user.name "Hangyu Feng"

# vim setup
if [ -d "~/.vim/bundle/Vundle.vim" ]; then
  cd ~/.vim/bundle/Vundle.vim && git pull && cd ~
else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# zsh setup
if [ ! -d "~/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ ! -d "~/antigen.zsh" ]; then
  curl -L git.io/antigen > ~/antigen.zsh  # zsh package manager
fi
chsh -s $(which zsh) && zsh

