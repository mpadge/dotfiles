#!/usr/bin/bash

r_args=")"
if [[ $# -ge 1 ]]; then
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a non-negative integer (got: $1)" >&2
        exit 1
    fi
    r_args=", max_depth = $1)"
fi

Rscript -e "mpmisc::workflow_updates(${r_args}"
