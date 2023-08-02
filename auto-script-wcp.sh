#!/usr/bin/bash
sudo apt update && sudo apt upgrade -y
cd /home/devops/workspaces/tz-vlp-labs 
git pull --quiet
/home/devops/workspaces/tz-vlp-labs/auto-script-wcp-run.sh
