#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then
    echo -e "${SYM} ${ARG}'daily' requires a single text argument${NC}    : ${TXT}update issue comment list.${NC}"
else
    Rscript -e "mpmisc::mpmisc_daily (\"$1\")"
fi
