#!/usr/bin/bash

if ([ "$1" == "" ] || [ "$1" == "help" ]); then
    echo -e "${SYM} ${ARG}no arguments or 'help'${NC} : ${TXT}Display this help.${NC}"
    echo -e "${SYM} ${ARG}us${NC}         : ${TXT}US keyboard${NC}"
    echo -e "${SYM} ${ARG}gb${NC}         : ${TXT}GB keyboard.${NC}"
    echo -e "${SYM} ${ARG}de${NC}     : ${TXT}DE keyboard${NC}"
    echo -e "${SYM} ${ARG}c${NC}      : ${TXT}Colemak keyboard${NC}"
elif [ "$1" == "us" ]; then
    setxkbmap us
elif [ "$1" == "gb" ]; then
    setxkbmap gb
elif [ "$1" == "de" ]; then
    setxkbmap de
elif [ "$1" == "c" ]; then
    # setxkbmap -v us -variant colemak_dh
    setxkbmap -v us -variant colemak
elif [ "$1" == "list" ]; then
    setxkbmap -print -verbose 10
else
    echo "keymap only accepts 'gb', de', 'c', or 'list'"
    exit 1
fi
