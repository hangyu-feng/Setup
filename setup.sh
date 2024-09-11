#!/bin/bash

set -u  # force var declaration

email="vailgrass@gmail.com"
username="Hangyu Feng"
packages=()
casks=()
os=undefined
pm=undefined
upgrade=0
no_package_install=false

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

detect_os() {
  case $(uname) in
    "Darwin")
      os="Mac"
      ;;
    "Linux")
      os="linux"
      ;;
    *)
      err "WARN: this script can only run on Mac or Linux systems!"
      exit 1
      ;;
  esac
  echo "current OS is $os"
}

process_args() {
  # getopts (bash) and getopt (mac) does not support long option, only GNU
  # getopt supports long option. So none of them will be used for sake of
  # cross-platform compatibility.
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
      "--casks="*)
        casks+=(${arg#"--casks="})
        ;;
      "--upgrade")
        upgrade=1
        ;;
      "--brew")
        pm=brew
        ;;
      "--no-packages")
        no_package_install=true
        ;;
      *)
        echo "the argument $arg is not valid"
        ;;
    esac
  done
}

set_package_manager() {
  # apt is the preferred package manager for Linux, and brew for macOS. If
  # the linux distro does not have apt, it will install brew instead to
  # avoid permission issues. Only apt and brew are supported since each
  # package manager has slightly different package names.
  # In future I might consider to switch to brew for every Unix system.
  which apt
  if [[ $? == 0 ]] && [[ $os == "linux" ]] && [[ $pm == undefined ]]; then
    pm="sudo $(which apt)"
    if [[ ! $pm =~ 'apt' ]]; then
      err 'apt not found'
      exit 1
    fi
  else
    which brew
    if [[ $? == 1 ]]; then
      echo "brew not found, installing homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      eval $(~/.linuxbrew/bin/brew shellenv)  # add brew to environment
    fi
    pm=$(which brew)
    if [[ ! $pm =~ brew ]]; then
      err "package manager '${pm}' is not set to brew"
      exit 1
    fi
  fi

  echo "package manager is set to '${pm}'"
}

install_packages() {
  echo "=== install packages ==="
  if [[ ${no_package_install} == true ]]; then
    packages=( zsh )
  elif [[ $pm =~ "apt" ]]; then
    packages+=( curl wget zsh git vim-gtk3 fzf silversearcher-ag ripgrep fonts-powerline unzip tar gzip)
  else  # using brew
    packages+=( curl wget zsh git vim fzf the_silver_searcher ripgrep )
    casks+=( visual-studio-code iterm2 homebrew/cask-fonts/font-fira-mono-for-powerline )
  fi
  if [[ $upgrade -gt 0 ]]; then
    $pm upgrade
  fi
  for package in "$@"; do
    which package
    if [[ $? == 1 ]]; then
      echo "installing $package: \`$pm install $package\`"
      $pm install $package
    fi
  done
}

install_casks() {
  echo "=== install casks ==="
  $pm cask install ${casks[@]}
}

download_configs() {
  echo "=== download config files ==="

  for config in .vimrc .zshrc .zprofile; do
    if [[ -f $config ]]; then
      mv $config "~/.old/${config#.}/${config}-$(date +'%Y-%m-%d_%H-%M-%S')"
    fi
  done
  curl --create-dir -o ~/setup/configs/.vimrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.vimrc
  curl --create-dir -o ~/setup/configs/.zshrc https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/.zshrc
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
  current_email=$(git config --global user.email)
  emails=( 'vailgrass@gmail.com' 'hangyu.feng@mail.utoronto.ca' 'hfeng@financeit.io' )
  if [[ ${emails[@]} =~ ${current_email} ]] ; then
    echo "git email is already set to ${current_email}"
  else
    echo "setting git user email to $1"
    git config --global user.email "$1"
  fi
  echo "setting git user name to $2"
  git config --global user.name "$2"
}

vim_setup() {
  echo "=== vim setup ==="
  echo "installing vim plugins"
  vim +PlugInstall +qall
}

zsh_setup() {
  echo "=== zsh setup ==="
  if [ ! -f ~/antigen.zsh ]; then
    echo "~/antigen.zsh folder doesn't exist, install antigen"
    curl -L git.io/antigen > ~/antigen.zsh  # zsh package manager
  else
    echo "antigen already installed"
  fi
  if [ ! -d ~/.oh-my-zsh ]; then # this will switch to zsh, so put it after antigen install
    echo "~/.oh-my-zsh folder doesn't exist, installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "~/.oh-my-zsh folder existed. To reinstall oh-my-zsh, remove ~/.oh-my-zsh folder before running the script."
  fi

  echo 'source ~/setup/configs/.zshrc' > ~/.zshrc
  echo 'source ~/setup/configs/.zprofile' > ~/.zprofile

  if [[ $SHELL =~ zsh ]]; then
    echo "default shell is zsh already"
  else
    echo "changing default shell to zsh"
    chsh -s $(which zsh)
    if [[ ! $SHELL =~ zsh ]]; then
      echo 'change default shell failed. it can be switched manually by adding `export SHELL=$(which zsh)` or `zsh` to .bashrc'
    fi
  fi
  if [[ $0 =~ zsh ]]; then
    echo "already running in zsh"
  else
    echo "switching to zsh"
    zsh
  fi
}

iterm2_setup() {
  curl --create-dir -o ~/setup/configs/iterm2/com.googlecode.iterm2.plist https://raw.githubusercontent.com/hangyu-feng/.setup/master/configs/iterm2/com.googlecode.iterm2.plist
  echo "remember to load iterm2 config at configs/iterm2 (General -> Preferences -> Load preferences from a custom folder or URL)"
}

main() {
  detect_os
  process_args "$@"
  set_package_manager
  install_packages ${packages[*]}
  if [[ $pm =~ "brew" ]] && [[ $os == mac ]]; then
    install_casks
  fi
  download_configs
  ssh_key
  git_configs "$email" "$username"
  vim_setup
  if [[ $os == "mac" ]]; then
    iterm2_setup
    echo ""
    echo "Here are some optional programs that can be installed:"
    echo "    brew cask install docker macs-fan-control turbo-boost-switcher fanny wechat"
    echo ""
  fi
  zsh_setup  # zsh setup should always be the last since it switch to zsh and pauses the script
}

main "$@"
