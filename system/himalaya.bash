#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[1;32m' # green, or 0;32m for darker green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then # check all
    echo -e "${SYM} ${TXT}email1${NC}"
    himalaya -a email1
    echo -e "${SYM} ${TXT}email2${NC}"
    himalaya -a email2
    # ...
elif [ "$2" == "" ]; then
    echo -e "${SYM} ${TXT}$1${NC}"
    himalaya -a $1
elif [ "$2" == "d" ]; then
    himalaya -a $1 delete $3
elif [ "$2" == "ss" ]; then
    himalaya -a $1 search subject $3
elif [ "$2" == "sb" ]; then
    himalaya -a $1 search body $3
else
    himalaya -a $1 read $2 | less
fi
