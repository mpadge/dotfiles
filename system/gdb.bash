#!/usr/bin/bash

echo "---------------------------------------------------"
echo "         Debug an R script with gdb"
echo "---------------------------------------------------"

read -p "Enter name of script: " SCRIPT
echo $SCRIPT

Rscript -e "mpmisc::gdb ()"
R -d gdb -e "source('$SCRIPT')"
