#!/usr/bin/bash

NC='\033[0m'       # no colour (reset)
ARG='\033[0;31m'   # red
TXT='\033[1;32m'   # green, or 0;32m for darker green
SYM='→' # right arrow

DEFAULT_ACCOUNT="email"
DEFAULT_FOLDER="inbox"

show_help () {
    echo -e "${TXT}himalaya.bash${NC}\n"
    echo "Usage: email [<account> [<option>] [<arg>] [<folder>]]"
    echo
    echo "  (no arguments)          List inbox of the default account ('${DEFAULT_ACCOUNT}')"
    echo "  all                     List inboxes of all configured accounts"
    echo "  help, -h, --help        Show this help"
    echo "  <account>               List inbox of the given account"
    echo "  <account> ls [<folder>] List <folder> of the given account"
    echo "  <account> <id> [<folder>]"
    echo "                          Read message <id>, paged through less"
    echo "                          (a 1-2 digit <id> reads that row of the folder listing)"
    echo "  <account> d <id> [<folder>]"
    echo "                          Delete message <id>"
    echo "  <account> ss <string> [<folder>]"
    echo "                          Search message subjects for <string>"
    echo "  <account> sb <string> [<folder>]"
    echo "                          Search message bodies for <string>"
    echo
    echo "<folder> is an optional final argument, defaulting to '${DEFAULT_FOLDER}'."
    echo "<account> is the name of an account configured in himalaya."
    echo "It may be omitted for ls, d, ss, sb, and <id>, in which case the default"
    echo "account ('${DEFAULT_ACCOUNT}') is used, e.g. 'email 123' or 'email ss invoice'."
    echo "Consequently, accounts must not be named d, ss, sb, ls, all, or be purely numeric."
}

# If the first arg is a command (ls, d, ss, sb) or a message id rather than an
# account name, prepend the default account so the positional logic below works.
# With no args at all, also use the default account.
if [ "$#" -eq 0 ] || [[ "$1" =~ ^(d|ss|sb|ls)$ ]] || [[ "$1" =~ ^[0-9]+$ ]]; then
    set -- "$DEFAULT_ACCOUNT" "$@"
fi

if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help
elif [ "$1" == "all" ]; then # no args: check all accounts
    echo -e "${SYM} ${TXT}email${NC}"
    himalaya -a email envelope list -m "$DEFAULT_FOLDER"
    # ... add further accounts here
elif [ "$2" == "" ]; then # account only: list its inbox
    echo -e "${SYM} ${TXT}$1${NC}"
    himalaya -a "$1" envelope list -m "$DEFAULT_FOLDER"
elif [ "$2" == "ls" ]; then # list folder $3
    folder="${3:-$DEFAULT_FOLDER}"
    echo -e "${SYM} ${TXT}$1${NC} (${folder})"
    himalaya -a "$1" envelope list -m "$folder"
elif [ "$2" == "d" ]; then # delete message with id $3 from folder $4
    himalaya -a "$1" message delete -m "${4:-$DEFAULT_FOLDER}" "$3"
elif [ "$2" == "ss" ]; then # search subject lines for $3 in folder $4
    himalaya -a "$1" envelope search -m "${4:-$DEFAULT_FOLDER}" subject "$3"
elif [ "$2" == "sb" ]; then # search message bodies for $3 in folder $4
    himalaya -a "$1" envelope search -m "${4:-$DEFAULT_FOLDER}" body "$3"
else # anything else is a message id: read it in a pager (folder $3)
    id="$2"
    folder="${3:-$DEFAULT_FOLDER}"
    if [[ "$id" =~ ^[0-9]{1,2}$ ]]; then
        # short number: position in the folder listing (1 = most recent)
        id=$(himalaya -a "$1" --json envelope list -m "$folder" | jq -r ".envelopes[$((id - 1))].id // empty")
        if [ -z "$id" ]; then
            echo "No message at position $2 in the ${folder} listing" >&2
            exit 1
        fi
    fi
    himalaya -a "$1" message read -m "$folder" "$id" | less
fi
