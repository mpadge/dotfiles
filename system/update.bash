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
echo -e "     ${NC}            4: node via nvm${NC}"
echo -e "     ${NC}            5: R packages${NC}"
echo -e "     ${NC}            6: LazyVim packages${NC}"
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
    rustup update
}

updateNode() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
        echo -e "${YEL}nvm not found in $NVM_DIR${NC}"
        return 1
    fi
    # nvm is a shell function, so must be sourced into this script
    \. "$NVM_DIR/nvm.sh"

    echo -e "${GRN}Currently active node:${NC} $(nvm current)"

    # Latest release of each of the 4 most recent LTS major versions
    echo -e "${YEL}Fetching available LTS versions ...${NC}"
    mapfile -t candidates < <(nvm ls-remote --lts --no-colors \
        | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' \
        | sort -uV \
        | awk -F. '{ latest[$1] = $0 } END { for (m in latest) print latest[m] }' \
        | sort -V | tail -n 4)
    if [ ${#candidates[@]} -eq 0 ]; then
        echo -e "${YEL}Could not list remote node versions${NC}"
        return 1
    fi

    echo -e "${YEL}Select node version to install:${NC}"
    local newver
    select newver in "${candidates[@]}" "Cancel"; do
        if [ "$newver" == "Cancel" ]; then
            echo -e "${YEL}Stopping node update${NC}"
            return 0
        elif [ -n "$newver" ]; then
            break
        fi
    done

    # Installed versions to migrate global packages from (excluding the new one)
    mapfile -t installed < <(nvm ls --no-colors \
        | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | sort -uV | grep -vxF "$newver")

    local oldver=""
    if [ ${#installed[@]} -gt 0 ]; then
        echo -e "${YEL}Select version to reinstall global packages from:${NC}"
        select oldver in "${installed[@]}" "None"; do
            if [ "$oldver" == "None" ]; then
                oldver=""
                break
            elif [ -n "$oldver" ]; then
                break
            fi
        done
    fi

    nvm install "$newver" || return 1
    nvm use "$newver"

    if [ -n "$oldver" ]; then
        nvm reinstall-packages "$oldver"
    fi
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
    doit "node via nvm"
    updateNode
elif [ "$OPT" == 5 ]; then
    doit "R packages"
    updateR
elif [ "$OPT" == 6 ]; then
    doit "neovim"
    updateNvim
elif [ "$OPT" == l ]; then
    paru -Qu
else
    echo "Unknown option"
    exit 1
fi
