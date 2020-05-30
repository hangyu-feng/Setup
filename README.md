# Setup

### Setup on Ubuntu/Debian:
  ```sh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh)"
  ```
  
  If you need to set different username, email, or add programs to install, you can download the script and run it by hand with arguments:
  ```sh
  curl -ofsSL ~/setup.sh "https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh"
  ~/.setup.sh --name="Your Name" --email="you@e.mail" --packages="package-1 package-2" --upgrade
  ```
  
  Note that all three options are optional
  
  Available Options:
  
  - `--name="Your Name"`
    
  - `--email="you@e.mail"`
    
  - `--packages="package-1 package-2"`
  
  - `--brew`: Use brew regardless of OS.
  
  - `--no-packages`: Only install zsh.
    
    - This list will add to default package list
      
    - Be sure to check package name. If you are on Ubuntu or Linux system that uses apt, you should search apt package name. Otherwise search for brew package name. A good example is that `ag` is called `silversearcher-ag` in apt and `the_silver_search` in brew.
      
  - `--upgrade`
    - This script do not upgrade all packages managed by the selected package manager by default. Pass in `--upgrade` to upgrade them

### Requirements:
  `bash`, `curl`, `git`

  Support for mac and other linux distros using package managers other than apt will come soon.
