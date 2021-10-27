#!/usr/bin/bash

NC='\033[0m'
TXT='\033[1;32m' # green, or 0;32m for darker green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then # check all
    echo -e "${SYM} ${TXT}email${NC}"
    himalaya -a email
    echo -e "${SYM} ${TXT}email2${NC}"
    himalaya -a email2
    # ...
if [ "$2" == "" ]; then
    echo -e "${SYM} ${TXT}$1${NC}"
    himalaya -a $1
elif [ "$2" == "d" ]; then
    himalaya -a $1 delete $3
else
    himalaya -a $1 read $2 | less
fi
