#!/bin/bash

# Script to delete all but the most recent 2 cache entries from GitHub for each
# different kind of cache key.
#
NC='\033[0m'
RED='\033[0;31m'
GRN='\033[0;32m' # or 1;32m for light green
ARRR='\u2192' # right arrow
ARRL='\u2190' # left arrow
DASH='\u2014'

echo -e "${GRN}${DASH}${DASH}${DASH}${ARRR} Remove old cache entries from GitHub ${ARRL}${DASH}${DASH}${DASH}${NC}"
echo -e ""

out_file="junk.json"
gh cache list --limit 100 --json id,key,createdAt,sizeInBytes > $out_file

ntot="$(jq 'map({
    id: .id,
    key: (.key | split("(") | first),
    createdAt: .createdAt,
}) | length' $out_file)"


n_remove="$(jq 'map({
    id: .id,
    key: (.key | split("(") | first)
}) |
    group_by(.key) |
    map(map(.id)[2:]) | flatten | length' $out_file)"

ids="$(jq 'map({
    id: .id,
    key: (.key | split("(") | first)
}) |
    group_by(.key) |
    map(map(.id)[2:]) | flatten | .[]' $out_file)"

echo "Total cache entries = $ntot, of which $n_remove will be removed."

read -p "Proceed(y/n)? " OPT
if [ "$OPT" == "y" ]; then
    for id in $ids; do
        gh cache delete $id
        echo "deleted cache id: $id"
    done
fi
rm "$out_file"
