#!/usr/bin/bash

if ! git -C . rev-parse; then
    exit 1
fi

url=$(git remote -v | grep origin | head -1 | awk '{print $2}')

if [[ "$url" == git@* ]]; then
    url="${url#git@}"
    url="${url/:/\/}"
    url="${url%.git}"
    url="https://$url"
fi

echo "opening $url"
xdg-open "$url" &
