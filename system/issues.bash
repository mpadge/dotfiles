#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then
    Rscript -e "dat <- mpmisc::latest_comments (); writeLines (dat[[\"repo_issue\"]], '~/Documents/issues')"
elif [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC}    : ${TXT}update issue comment list.${NC}"
    echo -e "${SYM} ${ARG}help${NC}            : ${TXT}display these help messages.${NC}"
    echo -e "${SYM} ${ARG}<repo>${NC}          : ${TXT}open GitHub issues page for <repo>.${NC}"
    echo -e "${SYM} ${ARG}<repo> <number>${NC} : ${TXT}open GitHub issue#<number> for <repo>.${NC}"
elif [ "$2" == "" ]; then
    Rscript -e "mpmisc::open_gh_issue (\"$1\")"
else
    Rscript -e "mpmisc::open_gh_issue (\"$1\", $2)"
fi
