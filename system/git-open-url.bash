#!/usr/bin/bash

# Usage: git-open-url.bash [all | <remote> ...]
#
# "all" opens every remote.
#
# Open the https URL of one or more remotes in the browser. With no args, opens
# the upstream remote, as set by `git config gitbin.upstream` (see
# .gitbin/git-push), falling back to "origin" if that is not set.

if ! git -C . rev-parse > /dev/null; then
    exit 1
fi

# Convert any remote URL (scp-like, ssh://, git://, http) to plain https
to_https () {
    local url="$1"
    case "$url" in
        https://*) ;;
        http://*) url="https://${url#http://}" ;;
        ssh://* | git://*)
            url="${url#*://}"
            url="${url#*@}"
            host="${url%%/*}"
            url="${host%%:*}/${url#*/}" # drop any port
            url="https://$url"
            ;;
        *@*:*)
            url="${url#*@}"
            url="https://${url/:/\/}"
            ;;
        *)
            return 1
            ;;
    esac
    echo "${url%.git}"
}

REMOTES=$(git remote)
if [ -z "$REMOTES" ]; then
    echo "No git remotes found" >&2
    exit 1
fi

if [ "$1" == "all" ]; then
    targets=($REMOTES)
elif [ $# -gt 0 ]; then
    targets=("$@")
else
    upstream=$(git config gitbin.upstream)
    if [ -z "$upstream" ]; then
        echo "gitbin.upstream not set; falling back to 'origin'" >&2
        upstream=origin
    fi
    targets=("$upstream")
fi

status=0
for name in "${targets[@]}"; do
    if ! grep -qx -- "$name" <<< "$REMOTES"; then
        echo "'$name' is not a remote of this repo (have: $(echo $REMOTES))" >&2
        status=1
        continue
    fi
    raw=$(git remote get-url "$name")
    if ! url=$(to_https "$raw"); then
        echo "Cannot convert '$raw' (remote '$name') to https" >&2
        status=1
        continue
    fi
    echo "opening $name: $url"
    xdg-open "$url" > /dev/null 2>&1 &
done
exit $status
