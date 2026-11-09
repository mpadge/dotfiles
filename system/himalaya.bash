#!/usr/bin/bash

# Usage:
#   himalaya.bash                     # list all configured inboxes
#   himalaya.bash <account>           # list inbox of one account
#   himalaya.bash <account> <id>      # read message <id>
#   himalaya.bash <account> d <id>    # delete message <id>
#   himalaya.bash <account> ss <str>  # search by subject
#   himalaya.bash <account> sb <str>  # search by body

# ANSI colour codes for output
NC='\033[0m'       # no colour (reset)
ARG='\033[0;31m'   # red
TXT='\033[1;32m'   # green, or 0;32m for darker green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then # no args: check all accounts
    echo -e "${SYM} ${TXT}email1${NC}"
    himalaya -a email1
    echo -e "${SYM} ${TXT}email2${NC}"
    himalaya -a email2
    # ... add further accounts here
elif [ "$2" == "" ]; then # account only: list its messages
    echo -e "${SYM} ${TXT}$1${NC}"
    himalaya -a $1
elif [ "$2" == "d" ]; then # delete message with id $3
    himalaya -a $1 delete $3
elif [ "$2" == "ss" ]; then # search subject lines for $3
    himalaya -a $1 search subject $3
elif [ "$2" == "sb" ]; then # search message bodies for $3
    himalaya -a $1 search body $3
else # anything else is a message id: read it in a pager
    himalaya -a $1 read $2 | less
fi
