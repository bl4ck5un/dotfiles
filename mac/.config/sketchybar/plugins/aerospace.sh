#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    /opt/homebrew/bin/sketchybar --set $NAME background.drawing=on
else
    /opt/homebrew/bin/sketchybar --set $NAME background.drawing=off
fi
