#!/usr/bin/bash

if [ "$1" == "" ]; then
    Rscript -e "mpmisc::gh_notifications ()"
else
    Rscript -e "mpmisc::open_gh_notification ($1)"
fi
