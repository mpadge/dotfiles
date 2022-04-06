#!/usr/bin/bash

# Set keymap for current X11 session, to enable easy temporary switching.

if [ "$1" == "" ]; then
    setxkbmap gb
elif [ "$1" == "de" ]; then
    setxkbmap de
elif [ "$1" == "list" ]; then
    setxkbmap -print -verbose 10
else
    echo "keymap only accepts 'de' or 'list'"
    exit 1
fi
