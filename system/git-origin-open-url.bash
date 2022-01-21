#!/usr/bin/bash

URL=$(git remote -v | grep origin | head -1 | sed 's/^origin\s//;s/\s.*$//')
firefox $URL &
