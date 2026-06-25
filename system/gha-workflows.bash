#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ] || [ "$1" == "help" ]; then
    echo -e "${TXT}Script to list all repositories with obsolete${NC}"
    echo -e "${TXT}or mis-named GitHub workflows.${NC}"
    echo -e ""
    echo -e "${SYM} ${ARG}versions${NC}       : ${TXT}Find all workflows with obsolete versions${NC}"
    echo -e "${SYM} ${ARG}names${NC}          : ${TXT}Find README badges with names different to actual workflows${NC}"
    echo -e "${SYM} ${ARG}help (default)${NC} : ${TXT}Display these help messages${NC}"
elif [ "$1" == "versions" ]; then
    Rscript -e "mpmisc::workflow_updates('$PWD')"
elif [ "$1" == "names" ]; then
    Rscript -e "mpmisc::workflow_badges('$PWD')"
else
    echo "Unknown option"
fi
