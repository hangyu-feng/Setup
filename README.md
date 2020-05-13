# Setup

#### setup ubuntu/debian:
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh)"
```
if you need to set different username, email, or add programs to install:
```sh
curl -fsSL https://raw.githubusercontent.com/hangyu-feng/.setup/master/setup.sh | bash -s --name="Your Name" --email="you@e.mail" --programs="program-1 program-2 program-3"
```

#### requirements:
  `curl`, `apt`

support for mac and other linux distros using package managers other than apt will come soon.
