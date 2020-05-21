#!/bin/bash

set -u  # force var declaration

email="vailgrass@gmail.com"
username="Hangyu Feng"
packages=undefined
os=undefined
pm=undefined
upgrade=0

detect_os() {
  case $(uname) in
    "Darwin")
      os="Mac"
      ;;
    "Linux")
      os="linux"
      ;;
    *)
      echo "WARN: this script can only run on Mac or Linux systems!" 1>&2
      exit 1
      ;;
  esac
  echo "current OS is $os"
}

package_manager() {
  # apt is the preferred package manager for Linux, and brew for macOS. If
  # the linux distro does not have apt, it will install brew instead to
  # avoid permission issues. Only apt and brew are supported since each
  # package manager has slightly different package names.
  # In future I might consider to switch to brew for every Unix system.
  which apt
  if [[ $? == 1 ]] && [[ $os == "linux" ]]; then
    pm="sudo $(which apt)"
  else
    which brew
    if [[ $? == 1 ]]; then
      echo "brew not found, install homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    pm=$(which brew)
  fi
  echo "package manager is set to $pm"
}

process_args() {
  # getopts (bash) and getopt (mac) does not support long option, only GNU
  # getopt supports long option. So none of them will be used for sake of
  # cross-platform compatibility.
  if [[ $pm =~ "apt" ]]; then
    packages=( curl wget zsh git vim-gtk3 fzf silversearcher-ag ripgrep )
  else  # using brew
    packages=( curl wget zsh git vim fzf the_silver_searcher ripgrep )
    casks=( visual-studio-code iterm2 microsoft-edge firefox spotify homebrew/cask-fonts/font-fira-mono-for-powerline wechat )
  fi
  for arg in "$@"; do
    case $arg in
      "--user="*)
        username=${arg#"--user="}
        ;;
      "--email="*)
        email=${arg#"--email="}
        ;;
      "--packages="*)
        packages+=(${arg#"--packages="})
        ;;
      "--upgrade")
        upgrade=1
        ;;
      *)
        echo "the argument $arg is not valid"
        ;;
    esac
  done
}

install_packages() {
  echo "=== install packages ==="
  if [[ $upgrade -gt 0 ]]; then
    $pm upgrade && $pm install "$@"
  else
    for package in "$@"; do
      which package
      if [[ $? == 1 ]]; then
        echo "install $package"
        $pm install $package
      fi
    done
  fi
}

install_casks() {
  echo "=== install casks ==="
  $pm cask install ${casks[@]}
}

download_configs() {
  echo "=== download config files ==="
  [ ! -f ~/.vimrc ] && curl -o ~/.vimrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.vimrc
  [ ! -f ~/.zshrc ] && curl -a ~/.zshrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.zshrc
}

ssh_key() {
  echo "=== detect / generate ssh key ==="
  # check for existing ssh key
  pub_key=undefined
  pub_key_names=( id_rsa.pub id_ecdsa.pub id_ed25519.pub )
  for filename in $(ls -a ~/.ssh); do
    for pub_key_name in ${pub_key_names[*]}; do
      if [[ $filename == $pub_key_name ]]; then
        pub_key=~/.ssh/$filename
      fi
    done
  done
  # generage ssh key if none exists
  if [[ $pub_key == undefined ]]; then
    ssh-keygen -t rsa -b 4096 -C $email
    eval "$(ssh-agent -s)"
    if [[ $os == "mac" ]]; then
      [[ ! -f ~/.ssh/config ]] && touch ~/.ssh/config
      ssh-add -K ~/.ssh/id_rsa
    else
      ssh-add ~/.ssh/id_rsa
    fi
    pub_key=~/.ssh/id_rsa.pub
  fi
  echo "public key is stored in $pub_key"
}

git_configs() {
  echo "=== git configs ==="
  echo "set git user email: $1"
  git config --global user.email "$1"
  echo "set git user name: $2"
  git config --global user.name "$2"
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

iterm2_setup() {
  echo "remember to load iterm2 config at configs/iterm2 (General -> Preferences -> Load preferences from a custom folder or URL)"
}

main() {
  detect_os
  package_manager
  process_args "$@"
  install_packages ${packages[*]}
  if [[ $pm =~ "brew" ]]; then
    install_casks
  fi
  download_configs
  ssh_key
  git_configs "$email" "$username"
  vim_setup
  if [[ $os == "mac" ]]; then
    iterm2_setup
  fi
  zsh_setup  # zsh setup should always be the last since it switch to zsh and pauses the script
}

main "$@"

