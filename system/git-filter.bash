#!/usr/bin/env bash
set -euo pipefail

WHAT="${1:?Usage: $0 <path-to-remove>}"

GIT_ROOT=$(git rev-parse --show-toplevel)
GIT_PREFIX=$(git rev-parse --show-prefix)   # path of cwd relative to git root
REL_PATH="${GIT_PREFIX}${WHAT}"             # works even if path no longer exists on disk

echo "Git root : ${GIT_ROOT}"
echo "Removing : ${REL_PATH}"

git -C "${GIT_ROOT}" filter-branch --force --index-filter \
    "git rm -r --cached --ignore-unmatch '${REL_PATH}'" \
    --prune-empty --tag-name-filter cat -- --all

# Afterwards, run this:
# git -C "${GIT_ROOT}" for-each-ref --format='delete %(refname)' refs/original | \
#     git -C "${GIT_ROOT}" update-ref --stdin
# git -C "${GIT_ROOT}" reflog expire --expire=now --all
# git -C "${GIT_ROOT}" gc --prune=now
