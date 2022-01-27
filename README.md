# Setup

### Setup on Ubuntu/Debian:

  This setup is a little bit heavy. I'm working on a more light-weight setup and get rid of brew installation etc.

  ```sh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh)"
  ```

  If you need to set different username, email, or add programs to install, you can download the script and run it by hand with arguments:
  ```sh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh)" "" --flag1 --flag2
  ```

  Note that all three options are optional

  Available Options:

  - `--name="Your Name"`

  - `--email="you@e.mail"`

  - `--packages="package-1 package-2"`

    - This list will add to default package list

    - Be sure to check package name. If you are on Ubuntu or Linux system that uses apt, you should search apt package name. Otherwise search for brew package name. A good example is that `ag` is called `silversearcher-ag` in apt and `the_silver_search` in brew.

  - `--upgrade`: This script do not upgrade all packages managed by the selected package manager by default. Pass in `--upgrade` to upgrade them

  - `--brew`: Use brew regardless of OS.

  - `--no-packages`: Only install zsh.

### Requirements:
  `bash`, `curl`, `git`

  Support for mac and other linux distros using package managers other than apt will come soon.

### Tricks and Techniques

  - [Job Control in ZSH and Bash](https://gist.github.com/CMCDragonkai/6084a504b6a7fee270670fc8f5887eb4)

  - To enable fzf.vim preview window scrolling: edit .vim/bundle/fzf.vim/bin/preview.sh
    - https://github.com/junegunn/fzf.vim/issues/1053
    - https://github.com/junegunn/fzf.vim/issues/751
    - comment out L50-54:
      ```sh
      if [ -z "$CENTER" ]; then
        CENTER=0
      fi
      ```

