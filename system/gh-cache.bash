#!/bin/bash

# GitHub has started restricting daily cache usage to 10GB, but only allows
# cache usage to be checked for individual repositories, with no way of getting
# an overview of which repos are using excessive cache.
#
# This script runs `gh cache` command on aslected sub-directories of specified
# paths, filters results with `jq` to previous 24-hour period, and puts all
# combined results in to a single output file in the directory where this
# script is run.
#
# The script should be run in a directory presumed to be two directories below
# where all git repositories sit, so each sub-dir should be `<org>/<repo>`.

if ! command -v jq &>/dev/null; then
    echo "jq must be installed."
    exit 1
fi
if ! command -v gh &>/dev/null; then
    echo "gh must be installed."
    exit 1
fi

json_file="gh-cache-dat.json" # files stored in each directory from `gh cache`
output_file="combined_data.json" # final output stored in pwd

echo "=== Running 'gh cache' on sub-directories ==="
find . -mindepth 2 -maxdepth 2 -type d | \
    grep -e "mpadge" -e "ropensci/" -e "UrbanAnalyst" -e "ropensci-review-tools" \
    | while read -r dir; do

    cd "$dir" || continue

    if gh cache list --json createdAt,sizeInBytes >> "$json_file" 2>/dev/null; then
        echo "  Generated dat.json in $dir successfully"
        if [ -f "$json_file" ] && [ -s "$json_file" ]; then
            twenty_four_hours_ago=$(date -u -d '24 hours ago' +'%Y-%m-%dT%H:%M:%SZ')
            jq --arg cutoff "$twenty_four_hours_ago" '
                if type == "array" then
                    [.[] | select(.createdAt >= $cutoff)]
                else
                    select(.createdAt >= $cutoff)
                end
            ' $json_file > temp.json && mv temp.json $json_file
        fi
    else
        echo "  No gh cache from $dir"
    fi

    cd - > /dev/null
done

echo "=== Combining data ==="
temp_file="combined_data_temp.json"
dirname=$(pwd)

echo "[" > "$temp_file"
first_entry=true

find . -mindepth 2 -maxdepth 3 -name "$json_file" | \
    grep -e "mpadge" -e "ropensci/" -e "UrbanAnalyst" -e "ropensci-review-tools" \
    | while read -r json_file; do

    json_path="${dirname}/${json_file#./}"

    if [ -s "$json_path" ] && command -v jq &>/dev/null; then
        json_content=$(cat "$json_file")
        if [ "$json_content" != "[]" ] && [ "$json_content" != "null" ] && [ -n "$json_content" ]; then
            if [ "$first_entry" = false ]; then
                echo "," >> "$temp_file"
            fi

            echo "   jq on ${json_path} ..."
            jq --arg path "$json_path" '
            if type == "array" then
                [.[] | .path = $path]
            else
                .path = $path
            end
            ' "$json_path" | sed '1d; $d' >> "$temp_file"

            first_entry=false
        fi
    fi
    rm "$json_path"
done

echo "]" >> "$temp_file"

# Then group results by "path" and store total sum of cache sizes:
if command -v jq &>/dev/null; then
    jq 'group_by(.path) |
        map({
            path: .[0].path,
            total_size_mb: (((map(.sizeInBytes) | add) / (1024 * 1024)) | round),
            count: length
        })' "$temp_file" > "$output_file"
else
    mv "$temp_file" "$output_file"
fi

rm -f "$temp_file"

echo "Combined data saved to $output_file"
echo "Total MB of cache in previous 24 hours:"
jq . "$output_file"
total_mb="$(jq 'map(.total_size_mb) | add' $output_file)"

echo "Overall total: $total_mb MB"
