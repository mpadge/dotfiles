#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

R_INSTALLED=$(pacman -Q r-base | sed 's/^\w*//')
R_CURRENT=$(pacman -Ss r-base | grep "/r " | cut -d ' ' -f 2)

if [ $R_INSTALLED != $R_CURRENT ]; then
    echo -e "\n${SYM}${TXT} Newer version of R available: ${ARG}${R_CURRENT}${NC}"
fi
