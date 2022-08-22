#!/usr/bin/bash

echo "---------------------------------------------------"
echo "         Debug an R script with gdb"
echo "---------------------------------------------------"

read -p "Enter name of script (empty = default 'script.R'): " SCRIPT

Rscript -e "mpmisc::gdb ()"

if [ "$SCRIPT" == "" ]; then
    R -d gdb -e "source('script.R')"
else
    R -d gdb -e "source('$SCRIPT')"
fi


