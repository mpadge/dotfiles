#!/usr/bin/bash

if [ "$1" == "" ]; then
    Rscript -e "dat <- mpmisc::latest_comments (); writeLines (dat$repo_issue, '~/Documents/issues')"
elif [ "$2" == "" ]; then
    Rscript -e "mpmisc::open_gh_issue (\"$1\")"
else
    Rscript -e "mpmisc::open_gh_issue (\"$1\", $2)"
fi
