#!/usr/bin/bash

if [ "$1" == "" ]; then
    Rscript -e "mpmisc::gh_notifications ()"
else if [ "$1" == "done" ]; then
    Rscript -e "mpmisc::mark_gh_notifications_as_read()"
else
    Rscript -e "mpmisc::open_gh_notification ($1)"
fi
