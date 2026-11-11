#!/usr/bin/env bash

# Print a random password of given length (default 10).
# Usage: random-password.bash [LENGTH]

set -euo pipefail

len="${1:-10}"

if ! [[ "$len" =~ ^[0-9]+$ ]] || [ "$len" -lt 1 ]; then
    echo "Usage: ${0##*/} [LENGTH]  (LENGTH must be a positive integer)" >&2
    exit 1
fi

# Read from urandom; `|| true` avoids SIGPIPE failure under pipefail
pw=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#%^&*_+=?' < /dev/urandom | head -c "$len" || true)
echo "$pw"
