#!/bin/bash

set -eu  # exit whenever a command failed and force var declaration

email="vailgrass@gmail.com"
username="Hangyu Feng"
programs=( curl wget zsh git vim-gtk3 fzf silversearcher-ag ripgrep )

install_programs() {
  echo "=== install basic programs ==="
  sudo apt update && sudo apt upgrade
  sudo apt install $*
}

download_configs() {
  echo "=== download config files ==="
  [ ! -f ~/.vimrc ] && curl -o ~/.vimrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.vimrc
  [ ! -f ~/.zshrc ] && curl -o ~/.zshrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.zshrc
}

ssh_key() {
  echo "=== detect / generate public key ==="
  pub_key=undefined
  filenames=( id_rsa.pub id_ecdsa.pub id_ed25519.pub )
  for existed in $(ls -a ~/.ssh); do
    for filename in ${filenames[*]}; do
      if [[ $existed == $filename ]]; then
        pub_key=~/.ssh/$existed
      fi
    done
  done
  if [[ $pub_key == undefined ]]; then
    ssh-keygen -t rsa -b 4096 -C $email
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    pub_key=~/.ssh/id_rsa.pub
  fi
  echo "public key is stored in $pub_key"
}

git_configs() {
  echo "=== git configs ==="
  echo "set git user email: $1"
  git config --global user.email $1
  echo "set git user name: $2"
  git config --global user.name $2
}

vim_setup() {
  echo "=== vim setup ==="
  if [ -d ~/.vim/bundle/Vundle.vim ]; then
    echo "update Vundle repo"
    cd ~/.vim/bundle/Vundle.vim && git pull && cd -
  else
    echo "clone Vundle repo"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
  echo "install vim plugins"
  vim +PluginInstall +qall
}

zsh_setup() {
  echo "=== zsh setup ==="
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "~/.oh-my-zsh folder doesn't exist, install oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "oh-my-zsh already installed"
  fi
  if [ ! -f ~/antigen.zsh ]; then
    echo "~/antigen.zsh folder doesn't exist, install antigen"
    curl -L git.io/antigen > ~/antigen.zsh  # zsh package manager
  else
    echo "antigen already installed"
  fi
  if [[ ! $SHELL =~ zsh ]]; then
    echo "switch to zsh"
    chsh -s $(which zsh) && zsh
  else
    echo "already in zsh"
  fi
}

main() {
  install_programs ${programs[*]}
  download_configs
  ssh_key
  git_configs $email $username
  vim_setup
  zsh_setup
}

main $*

