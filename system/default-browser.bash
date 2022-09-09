#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then
    echo -en "${TXT}Current default browser:${NC} "
    xdg-settings get default-web-browser
    echo -e "${TXT}Change by naming desired default browser, without the '.desktop' suffix${NC}"
    echo -e "${TXT}Current browsers are ${NC}'firefox'${TXT} and ${NC}'brave'"
else
    browser=$1
    browser=$(ls /usr/share/applications | grep "$browser")
    if [ "$browser" == "" ]; then
        echo -e "No broswer named '$(1)'"
        exit 1
    fi
    echo -e "Changing default browser to $browser"
    xdg-settings set default-web-browser "$browser"
fi
