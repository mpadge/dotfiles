#!/usr/bin/bash

if [ "$1" == "" ]; then
    setxkbmap us
elif [ "$1" == "gb" ]; then
    setxkbmap gb
elif [ "$1" == "de" ]; then
    setxkbmap de
elif [ "$1" == "c" ]; then
    setxkbmap -v us -variant colemak_dh
elif [ "$1" == "list" ]; then
    setxkbmap -print -verbose 10
else
    echo "keymap only accepts 'gb', de', 'c', or 'list'"
    exit 1
fi
