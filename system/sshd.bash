#!/usr/bin/bash

if [ "$1" == "" ] || [ "$1" == "start" ]; then
    sudo systemctl start tailscaled.service
    sudo tailscale up --ssh
elif [ "$1" == "stop" ]; then
    sudo tailscale down
    sudo systemctl stop tailscaled.service
elif [ "$1" == "status" ]; then
    tailscale status
else
    echo "server only accepts 'start', 'stop' or 'status'"
    exit 1
fi
