#!/usr/bin/env bash

URL="https://reviewbot.ropensci.org"
BOTCHECK_FILE="${BOTCHECK_FILE:-$HOME/.botcheck}"
TODAY=$(date -I)

if [[ -f "$BOTCHECK_FILE" ]] && [[ "$(cat "$BOTCHECK_FILE")" == "$TODAY" ]]; then
    exit 0
fi

YELLOW='\e[1;33m'
NC='\e[0m' # No Color

status=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

echo "$TODAY" > "$BOTCHECK_FILE"

if [[ "$status" != "404" ]]; then
    rm -f "$BOTCHECK_FILE"
    echo -e "$YELLOW                _              _           _      _          _                  $NC"
    echo -e "$YELLOW _ _  ___  _ _ [_] ___  _ _ _ | |_  ___  _| |_   [_] ___   _| | ___  _ _ _  _ _ $NC"
    echo -e "$YELLOW| '_]/ ._]| | || |/ ._]| | | || . \/ . \  | |    | |[_-[  / . |/ . \| | | || ' |$NC"
    echo -e "$YELLOW|_|  \___.|__/ |_|\___.|__/_/ |___/\___/  |_|    |_|/__/  \___|\___/|__/_/ |_|_|$NC"
    exit 1
fi
