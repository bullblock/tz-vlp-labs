#!/usr/bin/bash
cd /home/devops/workspaces/tz-vlp-labs &> /dev/bull
git pull --quiet
/home/devops/workspaces/tz-vlp-labs/auto-script-wcp-run.sh
