#!/usr/bin/bash

if ! git -C . rev-parse; then
    exit 1
fi

uo=$(git remote -v | grep origin | head -1 | sed 's/^\w*//' | tr -s ' ' | cut -d ' ' -f 1)
uu=$(git remote -v | grep upstream | head -1 | sed 's/^\w*//' | tr -s ' ' | cut -d ' ' -f 1)

if [[ $uu ]]; then
    echo "opening $uu"
    xdg-open $uu &
else
    echo "opening $uo"
    xdg-open $uo &
fi
