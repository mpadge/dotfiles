#!/bin/bash
read -p "User name for 'https://github.com': " UNAME
read -s -p "Password -- NOT PAT! -- for 'https://$UNAME@github.com' " PASS
echo ""

# encryption:
-openssl des3 -salt -md sha256 -pbkdf2 -d -in <path/to/encrypted/file> -out <unencrypted/version> -pass pass:$PASS

PASS=""
PAT=$(<unencrypted_version)
rm <unencrypted_version>

# get git remote address:
if [ "$1" == "" ]; then
    BRANCH=$(git branch --show-current)
else
    BRANCH=$1
fi

REMOTE=$(git remote -v | head -n 1)
# REMOTE="origin https://github.com/<org>/<repo> (fetch)" (or similar)

# function to cut string by delimiter
cut () {
    local s=$REMOTE$1
    while [[ $s ]]; do
        array+=( "${s%%"$1"*}" );
        s=${s#*"$1"};
    done;
}
# cut terminal bit "(fetch)" from remote, returning first part as array[0]:
array=();
cut " "
REMOTE="${array[0]}"

# cut remainder around "github.com", returning 2nd part as "/<org>/<repo>"
array=();
cut "github.com"

# convert REMOTE given above to
# REMOTE="https://<UNAME>:<PAT>@github.com/<org>/<repo>" (or similar)
printf -v REMOTE "https://%s:%s@github.com%s" "$UNAME" "$PAT" "${array[1]}"
#echo $REMOTE $BRANCH

git push $REMOTE $BRANCH
# need to git pull for some reason in order to properly reset head to remote
git pull &>/dev/null
# clear variables:
PAT=""
REMOTE=""

# repeat push for other remotes
REMOTE=$(git remote -v | grep "originbb" | head -n 1) # bitbucket
if [ -n "$REMOTE" ]; then # -n -> is non-zero string
    echo ""
    echo -n "--------Pushing to bitbucket "
    git push originbb $BRANCH
fi
REMOTE=$(git remote -v | grep "origingl" | head -n 1) # gitlab
if [ -n "$REMOTE" ]; then # -n -> is non-zero string
    echo ""
    echo -n "--------Pushing to gitlab "
    git push origingl $BRANCH
fi
REMOTE=$(git remote -v | grep "originsh" | head -n 1) # sourcehut
if [ -n "$REMOTE" ]; then # -n -> is non-zero string
    echo ""
    echo -n "--------Pushing to sourcehut "
    git push originsh $BRANCH
fi
REMOTE=$(git remote -v | grep "origincb" | head -n 1) # codeberg
if [ -n "$REMOTE" ]; then # -n -> is non-zero string
    echo ""
    echo -n "--------Pushing to codeberg "
    git push origincb $BRANCH
fi
