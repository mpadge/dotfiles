#!/bin/bash

# Script to switch colour schemes from dark to light

ALACRITTY_CONFIG=~/.config/alacritty/alacritty.toml

if [ "$1" == "" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Display these help messages.${NC}"
    echo -e "${SYM} ${ARG}light${NC}         : ${TXT}Switch to light colour scheme.${NC}"
    echo -e "${SYM} ${ARG}dark${NC}         : ${TXT}Switch to dark colour scheme.${NC}"
elif [ "$1" == "light" ]; then
    sed -i '/^export NVIM_COLOUR_SCHEME/c\export NVIM_COLOUR_SCHEME="catppuccin-latte"' ~/.bashrc
    perl -pi -e 's/^[ \t]+"~\/.config\/alacritty.*$/    "~\/.config\/alacritty\/themes\/everforest_light.toml"/' $ALACRITTY_CONFIG
    perl -pi -e 's/^background.*$/background = "#fdf6e3"/' $ALACRITTY_CONFIG
    perl -pi -e 's/^foreground.*$/foreground = "#5c6a72"/' $ALACRITTY_CONFIG
elif [ "$1" == "dark" ]; then
    sed -i '/^export NVIM_COLOUR_SCHEME/c\export NVIM_COLOUR_SCHEME="none"' ~/.bashrc
    perl -pi -e 's/^[ \t]+"~\/.config\/alacritty.*$/    "~\/.config\/alacritty\/themes\/omni.toml"/' $ALACRITTY_CONFIG
    perl -pi -e 's/^background.*$/background = "#191622"/' $ALACRITTY_CONFIG
    perl -pi -e 's/^foreground.*$/foreground = "#e1e1e6"/' $ALACRITTY_CONFIG
fi
