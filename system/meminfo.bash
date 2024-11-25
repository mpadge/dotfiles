#!/bin/bash

# Read MemTotal and MemAvailable from /proc/meminfo
MemTotal=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
MemAvailable=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

# Convert to integers for safe division
MemTotal=$((MemTotal / 1024))
MemAvailable=$((MemAvailable / 1024))

Ratio=$(echo "scale=2; $MemAvailable / $MemTotal" | bc -l)

if (( $(echo "$Ratio < 0.5" | bc -l) )); then
    Msg="Less than $Ratio of memory is available"
    notify-send --urgency=high "$Msg"
fi
