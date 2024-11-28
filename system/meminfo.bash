#!/bin/bash

# A script to debug memory issues i was having. This is intended to be run on a
# CRON job, and will issue a 'notify-send' warning if memory usage exceeds 50%
# of available memory.

USER=$(whoami)
ICON="/usr/share/icons/breeze-dark/status/64/dialog-warning.svg"

# Read MemTotal and MemAvailable from /proc/meminfo
MemTotal=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
MemAvailable=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

# Convert to integers for safe division
MemTotal=$((MemTotal / 1024))
MemAvailable=$((MemAvailable / 1024))

Ratio=$(echo "scale=2; $MemAvailable / $MemTotal" | bc -l)
RatioPC=$(echo "scale=4; ($MemAvailable / $MemTotal) * 100" | bc -l)
RatioPC=$(echo "scale=0; $RatioPC" | bc) # round down to int
RatioPC=$(printf "%.0f%%" "$RatioPC") # convert to string %

if (( $(echo "$Ratio < 0.5" | bc -l) )); then
    Msg="Less than $RatioPC of memory is available"
    sudo -u "$USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --urgency=critical -i $ICON "$Msg"
fi

# Then with fcron:
# sudo fcrontab -u <user> -e
# or to see status
# sudo fcrontab -u <user> -l
# to debug fcrontab calls:
# sudo systemctl status fcron.service
