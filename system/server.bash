#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

MACHINE='machine-name'
USER='user-name'

if [ "$1" == "" ]; then
    ssh ${USER}@${MACHINE}
elif [ "$1" == "stop" ]; then
    ssh -t ${USER}@${MACHINE} 'sudo systemctl poweroff'
elif [ "$1" == "suspend" ]; then
    ssh -t ${USER}@${MACHINE} 'sudo systemctl suspend'
elif [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Connect to ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}stop${NC}         : ${TXT}Turn off ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}suspend${NC}      : ${TXT}Suspend ${MACHINE}.${NC}"
    echo -e "${SYM} ${ARG}help${NC}         : ${TXT}Display these help messages${NC}"
else
    echo "Parameter not recognised; see '${MACHINE} help' for details"
    exit 1
fi
