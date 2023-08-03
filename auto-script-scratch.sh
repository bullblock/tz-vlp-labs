#!/usr/bin/bash
sudo apt update && sudo apt upgrade -y
brew update
brew upgrade
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pip-review
pip-review -a -C 2> /dev/null
cd /home/devops/workspaces/tz-vlp-labs 
git pull --quiet
