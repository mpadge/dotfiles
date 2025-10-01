#!/usr/bin/bash

NC='\033[0m'
# RED='\033[0;31m' # red
GRN='\033[0;32m' # green, or 1;32m for light green
YEL='\033[0;33m'
ARR='\u2192' # right arrow
DASH='\u2014'

echo -e "${GRN}╔═══╗╔╗  ╔╗╔═══╗╔════╗╔═══╗╔═╗╔═╗    ╔╗ ╔╗╔═══╗╔═══╗╔═══╗╔════╗╔═══╗${NC}"
echo -e "${GRN}║╔═╗║║╚╗╔╝║║╔═╗║║╔╗╔╗║║╔══╝║║╚╝║║    ║║ ║║║╔═╗║╚╗╔╗║║╔═╗║║╔╗╔╗║║╔══╝${NC}"
echo -e "${GRN}║╚══╗╚╗╚╝╔╝║╚══╗╚╝║║╚╝║╚══╗║╔╗╔╗║    ║║ ║║║╚═╝║ ║║║║║║ ║║╚╝║║╚╝║╚══╗${NC}"
echo -e "${GRN}╚══╗║ ╚╗╔╝ ╚══╗║  ║║  ║╔══╝║║║║║║    ║║ ║║║╔══╝ ║║║║║╚═╝║  ║║  ║╔══╝${NC}"
echo -e "${GRN}║╚═╝║  ║║  ║╚═╝║ ╔╝╚╗ ║╚══╗║║║║║║    ║╚═╝║║║   ╔╝╚╝║║╔═╗║ ╔╝╚╗ ║╚══╗${NC}"
echo -e "${GRN}╚═══╝  ╚╝  ╚═══╝ ╚══╝ ╚═══╝╚╝╚╝╚╝    ╚═══╝╚╝   ╚═══╝╚╝ ╚╝ ╚══╝ ╚═══╝${NC}"
echo ""
echo -e "${YEL}${DASH}${DASH}${ARR}  ${NC}Enter/Default: All${NC}"
echo -e "     ${NC}            1: pacman${NC}"
echo -e "     ${NC}            2: AUR via paru${NC}"
echo -e "     ${NC}            3: cargo via rustup${NC}"
echo -e "     ${NC}            4: R packages${NC}"
echo -e "     ${NC}            5: LazyVim packages${NC}"
echo -e "     ${NC}            l: List all paru updates${NC}"
echo -e "${GRN}---------------------------------------------------${NC}"

doit() {
    echo -e -n "${YEL}Proceed to update $1 (y/n)?${NC} "
    read DOIT
    if [ "$DOIT" != "y" ]; then
        echo -e "${YEL}Stopping update${NC}"
        exit 0
    fi
}

updateParu() {
    paru -Syu --ignore v8-r
}

updatePacman() {
    sudo pacman -Syu
}

updateCargo() {
    sudo rustup update
}

updateR() {
    echo 'update.packages(ask=FALSE)' | sudo R --no-save -q
}

updateNvim() {
    nvim --headless "+Lazy! sync" +qa
    nvim --headless "+TSUpdate" +qa
}

echo -e -n "${YEL}Enter option:${NC} "
read OPT

if [[ -z "$OPT"  ]]; then
    doit "everything (paru, cargo, R packages, and neovim)"
    updateParu && updateCargo && updateR && updateNvim
elif [ "$OPT" == 1 ]; then
    doit "pacman"
    updatePacman
elif [ "$OPT" == 2 ]; then
    doit "paru"
    updateParu
elif [ "$OPT" == 3 ]; then
    doit "cargo"
    updateCargo
elif [ "$OPT" == 4 ]; then
    doit "R packages"
    updateR
elif [ "$OPT" == 5 ]; then
    doit "neovim"
    updateNvim
elif [ "$OPT" == l ]; then
    paru -Qu
else
    echo "Unknown option"
    exit 1
fi
