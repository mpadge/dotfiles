#!/bin/bash

effects=("beams" "binarypath" "blackhole" "bouncyballs" "bubbles" "burn"
    "colorshift" "crumble" "decrypt" "errorcorrect" "expand" "fireworks"
    "middleout" "orbittingvolley" "overflow" "pour" "print" "rain"
    "randomsequence" "rings" "scattered" "slice" "slide" "spotlights" "spray"
    "swarm" "synthgrid" "unstable" "vhstape" "waves" "wipe")
       
random_index=$((RANDOM % ${#effects[@]}))
effect="${effects[random_index]}"

tte $effect
