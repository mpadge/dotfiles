#!/usr/bin/bash

if [ "$2" == "" ]; then
    himalaya -a $1
elif [ "$2" == "d" ]; then
    himalaya -a $1 delete $3
else
    himalaya -a $1 read $2 | less
fi
