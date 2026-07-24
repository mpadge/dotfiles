#!/usr/bin/env bash
# Usage: ./find-remote.sh <pattern>
# Lists directories (searched 2 levels deep from cwd) whose git remotes
# contain <pattern> (e.g. "gitlab").

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <remote-pattern>" >&2
    exit 1
fi

pattern="$1"

find . -mindepth 2 -maxdepth 3 -type d -name .git | while read -r gitdir; do
    repo="$(dirname "$gitdir")"
    if git -C "$repo" remote -v 2>/dev/null | grep -q "$pattern"; then
        echo "$repo"
    fi
done
