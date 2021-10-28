#!/usr/bin/bash

if [ "$1" == "" ]; then
    Rscript -e "mpmisc::gh_notifications ()"
elif [ "$1" == "done" ]; then
    Rscript -e "mpmisc::mark_gh_notifications_as_read()"
elif [[ "$1" =~ ^[0-9]+$ ]]; then
    Rscript -e "mpmisc::open_gh_notification ($1)"
else
    echo "gn only accepts 'done' or a single number"
    exit 1
fi
