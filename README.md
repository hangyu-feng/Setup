# Setup

### setup on ubuntu/debian:
  ```sh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh)"
  ```
  if you need to set different username, email, or add programs to install, you can download the script and run it by hand with arguments:
  ```sh
  curl -ofsSL ~/setup.sh "https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh"
  ~/.setup.sh --name="Your Name" --email="you@e.mail" --programs="program-1 program-2"
  ```
  note that all three options are optional, and setting programs will only add to the list of programs to be installed/

### requirements:
  `bash`, `curl`, `apt`

  support for mac and other linux distros using package managers other than apt will come soon.
