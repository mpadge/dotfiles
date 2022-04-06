#!/usr/bin/bash

if [ "$1" == "" ]; then
    sudo systemctl start sshd.service
elif [ "$1" == "stop" ]; then
    sudo systemctl stop sshd.service
elif [ "$1" == "status" ]; then
    sudo systemctl status sshd.service
else
    echo "ssdh only accepts 'stop' or 'status'"
    exit 1
fi
