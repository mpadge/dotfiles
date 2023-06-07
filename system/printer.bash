#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ] || [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Display these help messages.${NC}"
    echo -e "${SYM} ${ARG}on${NC}           : ${TXT}Turn printer services on.${NC}"
    echo -e "${SYM} ${ARG}<number>${NC}     : ${TXT}Turn printer services off${NC}"
elif [ "$1" == "on" ]; then
    sudo systemctl start cups.service avahi-daemon.service
elif [ "$1" == "off" ]; then
    sudo systemctl stop cups.service avahi-daemon.service
else
    echo "Parameter not recognised; see 'printer help' for details"
    exit 1
fi
