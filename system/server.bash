#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

MACHINE='machine-name'
USER='user-name'
MODEMURL='https://mymodel.myfritz.net:444/myfritz'

STATUS=$(tailscale status | grep ${MACHINE})

if [ "$1" == "" ]; then
    ssh ${USER}@${MACHINE}
elif [ "$1" == "status" ]; then
    if grep -q 'relay' <<< "${STATUS}"; then
        echo -e "${SYM} ${ARG}${MACHINE}${TXT} is sleeping${NC}"
    elif grep -q 'offline' <<< "${STATUS}"; then
        echo -e "${SYM} ${ARG}${MACHINE}${TXT} is sleeping${NC}"
    else
        echo -e "${SYM} ${ARG}${MACHINE}${TXT} is active${NC}"
    fi
elif [ "$1" == "stop" ] || [ "$1" == "off" ]; then
    ssh -t ${USER}@${MACHINE} 'sudo systemctl poweroff'
elif [ "$1" == "suspend" ] || [ "$1" == "sleep" ]; then
    ssh -t ${USER}@${MACHINE} 'sudo systemctl suspend'
elif [ "$1" == "wake" ]; then
    xdg-open ${MODEMURL} &
elif [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC}  : ${TXT}Connect to ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}status${NC}        : ${TXT}Display status of ${MACHINE}${NC}"
    echo -e "${SYM} ${ARG}stop/off${NC}      : ${TXT}Turn off ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}suspend/sleep${NC} : ${TXT}Suspend ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}wake${NC}          : ${TXT}Wake ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}help${NC}          : ${TXT}Display these help messages${NC}"
else
    echo "Parameter not recognised; see '${MACHINE} help' for details"
    exit 1
fi
