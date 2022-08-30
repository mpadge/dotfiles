#!/usr/bin/bash

echo "---------------------------------------------------"
echo "         Debug an R script with gdb or lldb"
echo "---------------------------------------------------"

read -p "Enter name of script (empty = default 'script.R'): " SCRIPT

Rscript -e "mpmisc::debug(); pkgbuild::compile_dll()"

DEBUGGER=gdb

if [ "$SCRIPT" == "" ]; then
    R -d $DEBUGGER -e "source('script.R')"
else
    R -d $DEBUGGER -e "source('$SCRIPT')"
fi
