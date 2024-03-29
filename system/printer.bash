#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

PRINTER='Canon'

if [ "$1" == "" ] || [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Display these help messages.${NC}"
    echo -e "${SYM} ${ARG}on/start${NC}     : ${TXT}Turn printer services on.${NC}"
    echo -e "${SYM} ${ARG}off/stop${NC}     : ${TXT}Turn printer services off${NC}"
    echo -e "${SYM} ${ARG}status${NC}       : ${TXT}Display status of printer services${NC}"
elif [ "$1" == "on" ] || [ "$1" == "start" ]; then
    sudo systemctl start cups.service avahi-daemon.service
elif [ "$1" == "off" ] || [ "$1" == "stop" ]; then
    sudo systemctl stop cups.service avahi-daemon.service
elif [ "$1" == "status" ]; then
    avahi-browse --all --ignore-local --resolve --terminate | grep ${PRINTER}
else
    echo "Parameter not recognised; see 'printer help' for details"
    exit 1
fi

# Printer queue manipulation:
# lpq -a
# lprm <Job Number>
