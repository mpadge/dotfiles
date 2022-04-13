#!/usr/bin/bash

NC='\033[0m'
ARG='\033[0;31m' # red
TXT='\033[0;32m' # green, or 1;32m for light green
SYM='\u2192' # right arrow

if [ "$1" == "" ]; then
    Rscript -e "mpmisc::gh_notifications ()"
elif [ "$1" == "done" ]; then
    Rscript -e "mpmisc::mark_gh_notifications_as_read()"
elif [[ "$1" =~ ^[0-9]+$ ]]; then
    Rscript -e "mpmisc::open_gh_notification ($1)"
elif [ "$1" == "commits" ]; then
    Rscript -e "mpmisc::gh_daily_commits ()"
elif [ "$1" == "help" ]; then
    echo -e "${SYM} ${ARG}no arguments${NC} : ${TXT}Display new GitHub notifications.${NC}"
    echo -e "${SYM} ${ARG}help${NC}         : ${TXT}Display these help messages.${NC}"
    echo -e "${SYM} ${ARG}done${NC}         : ${TXT}Mark all GitHub notifications as read.${NC}"
    echo -e "${SYM} ${ARG}<number>${NC}     : ${TXT}open nominated GitHub notification.${NC}"
    echo -e "${SYM} ${ARG}commits${NC}      : ${TXT}Count number of daily commits.${NC}"
else
    echo "Parameter not recognised; see 'gh help' for details"
    exit 1
fi
