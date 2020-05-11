#!/bin/bash

set -e  # exit whenever a command failed

echo "install basic programs: curl, zsh, git, vim-gtk3"
sudo apt update && sudo apt upgrade
sudo apt install curl wget zsh git vim-gtk3  # vim-gtk3 provides extended features like clipboard for ubuntu

echo "copy config files"
cp ./.vimrc ./.zshrc ~
cd ~

# git
echo "set git user email: 'vailgrass@gmail.com'"
git config --global user.email "vailgrass@gmail.com"
echo "set git user name: Hangyu Feng"
git config --global user.name "Hangyu Feng"

# vim setup
if [ -d "~/.vim/bundle/Vundle.vim" ]; then
  echo "update Vundle repo"
  cd ~/.vim/bundle/Vundle.vim && git pull && cd ~
else
  echo "clone Vundle repo"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
echo "install vim plugins"
vim +PluginInstall +qall

# zsh setup
if [ ! -d "~/.oh-my-zsh" ]; then
  echo "~/.oh-my-zsh folder doesn't exist, install oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ ! -d "~/antigen.zsh" ]; then
  echo "~/antigen.zsh folder doesn't exist, install antigen"
  curl -L git.io/antigen > ~/antigen.zsh  # zsh package manager
fi
chsh -s $(which zsh) && zsh

