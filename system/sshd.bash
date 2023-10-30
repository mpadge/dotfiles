#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ] || [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Display these help messages.${NC}"
    echo -e "${SYM} ${ARG}on/start${NC}     : ${TXT}Turn tailscale service on.${NC}"
    echo -e "${SYM} ${ARG}off/stop${NC}     : ${TXT}Turn tailscale service off${NC}"
    echo -e "${SYM} ${ARG}status${NC}       : ${TXT}Display status of tailscale service${NC}"
elif [ "$1" == "start" ] || [ "$1" == "on" ]; then
    sudo systemctl start tailscaled.service
    sudo tailscale up --ssh
elif [ "$1" == "stop" ] || [ "$1" == "off" ]; then
    sudo tailscale down
    sudo systemctl stop tailscaled.service
elif [ "$1" == "status" ]; then
    tailscale status
else
    echo "server only accepts 'start', 'on', 'stop', 'off', or 'status'"
    exit 1
fi
