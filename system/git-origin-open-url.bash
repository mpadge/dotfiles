#!/usr/bin/bash

u=$(git remote -v | grep origin | head -1 | sed 's/^\w*//' | tr -s ' ' | cut -d ' ' -f 1)
echo "opening $u"
xdg-open $u &
