#!/usr/bin/bash

NC='\033[0m'       # no colour (reset)
ARG='\033[0;31m'   # red
TXT='\033[1;32m'   # green, or 0;32m for darker green
SYM='\u2192' # right arrow

show_help () {
    echo -e "${TXT}himalaya.bash${NC}\n"
    echo "Usage: email [<account> [<option>] [<arg>]]"
    echo
    echo "  (no arguments)          List inbox of the default account ('${DEFAULT_ACCOUNT}')"
    echo "  all                     List inboxes of all configured accounts"
    echo "  help, -h, --help        Show this help"
    echo "  <account>               List inbox of the given account"
    echo "  <account> <id>          Read message <id>, paged through less"
    echo "                          (a 1-2 digit <id> reads that row of the inbox listing)"
    echo "  <account> d <id>        Delete message <id>"
    echo "  <account> ss <string>   Search message subjects for <string>"
    echo "  <account> sb <string>   Search message bodies for <string>"
    echo
    echo "<account> is the name of an account configured in himalaya."
    echo "It may be omitted for d, ss, sb, and <id>, in which case the default"
    echo "account ('${DEFAULT_ACCOUNT}') is used, e.g. 'email 123' or 'email ss invoice'."
    echo "Consequently, accounts must not be named d, ss, sb, all, or be purely numeric."
}

# If the first arg is a command (d, ss, sb) or a message id rather than an
# account name, prepend the default account so the positional logic below works.
DEFAULT_ACCOUNT="email"
# With no args at all, also use the default account.
if [ "$#" -eq 0 ] || [[ "$1" =~ ^(d|ss|sb)$ ]] || [[ "$1" =~ ^[0-9]+$ ]]; then
    set -- "$DEFAULT_ACCOUNT" "$@"
fi

if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help
elif [ "$1" == "all" ]; then # no args: check all accounts
    echo -e "${SYM} ${TXT}email1${NC}"
    himalaya -a email1 envelope list
    echo -e "${SYM} ${TXT}email2${NC}"
    himalaya -a email2 envelope list
    # ... add further accounts here
elif [ "$2" == "" ]; then # account only: list its messages
    echo -e "${SYM} ${TXT}$1${NC}"
    himalaya -a $1 envelope list
elif [ "$2" == "d" ]; then # delete message with id $3
    himalaya -a "$1" message delete "$3"
elif [ "$2" == "ss" ]; then # search subject lines for $3
    himalaya -a "$1" envelope search subject "$3"
elif [ "$2" == "sb" ]; then # search message bodies for $3
    himalaya -a "$1" envelope search body "$3"
else # anything else is a message id: read it in a pager
    id="$2"
    if [[ "$id" =~ ^[0-9]{1,2}$ ]]; then
        # short number: position in the inbox listing (1 = most recent)
        id=$(himalaya -a "$1" --json envelope list | jq -r ".envelopes[$((id - 1))].id // empty")
        if [ -z "$id" ]; then
            echo "No message at position $2 in the inbox listing" >&2
            exit 1
        fi
    fi
    himalaya -a "$1" message read "$id" | less
fi
