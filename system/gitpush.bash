#!/bin/bash
read -p "User name for 'https://github.com': " UNAME
read -s -p "Password -- NOT PAT! -- for 'https://$UNAME@github.com' " PASS
echo ""

# encryption:
GITTOK="aaagit.txt"
openssl des3 -salt -md sha256 -pbkdf2 -d \
    -in /data/mega/system/aaagit -out "$GITTOK" -pass pass:$PASS

PASS=""
PAT=$(cat "$GITTOK")
rm "$GITTOK"

# get git remote address:
if [ "$1" == "" ]; then
    BRANCH=$(git branch --show-current)
else
    BRANCH=$1
fi

REMOTE_GH=$(git remote -v | grep "github\.com" | grep "(fetch)" | head -n 1)
if [ -z "$REMOTE_GH" ]; then
    echo "No github.com remote found" >&2
    exit 1
fi
# REMOTE_GH="origin https://github.com/<org>/<repo> (fetch)" (or similar)

# function to cut string by delimiter
cut () {
    local s=$REMOTE_GH$1
    while [[ $s ]]; do
        array+=( "${s%%"$1"*}" );
        s=${s#*"$1"};
    done;
}
# cut terminal bit "(fetch)" from remote, returning first part as array[0]:
array=();
cut " "
REMOTE_GH="${array[0]}"

# cut remainder around "github.com", returning 2nd part as "/<org>/<repo>"
array=();
cut "github.com"

# convert REMOTE_GH given above to
# REMOTE_GH="https://<UNAME>:<PAT>@github.com/<org>/<repo>" (or similar)
printf -v REMOTE_GH "https://%s:%s@github.com%s" "$UNAME" "$PAT" "${array[1]}"
#echo $REMOTE_GH $BRANCH

git push $REMOTE_GH $BRANCH
# need to git pull for some reason in order to properly reset head to remote
git pull &>/dev/null
# clear variables:
PAT=""
REMOTE_GH=""

# repeat push for other remotes
if [[ "$BRANCH" == "main" ]]; then
    # remove the github remote, then loop over all remaining ones
    git remote -v | grep -v "github\.com" | while read -r name url type; do
    # only "push" remotes to avoid duplicates
    if [[ "$type" == "(push)" ]]; then
        echo ""
        echo -n "--------Pushing to $name- "
        # Explicit refspec: a bare `git push <url>` uses the upstream
        # branch, which fails for any URL other than the tracked remote.
        # Also continue past failures, and keep git from consuming the loop's
        # stdin.
        git push "$url" "refs/heads/$BRANCH:refs/heads/$BRANCH" < /dev/null \
            || echo "Push to $name failed; continuing"
    fi
done
fi
echo ""
