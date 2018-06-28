#!/bin/bash
# hide the dark widgets in the ui folder
osascript /usr/local/bin/scripts/ui/hideDarkWidgets.scpt
# show the light widgets in the ui folder
osascript /usr/local/bin/scripts/ui/showLightWidgets.scpt

# get our image folder
folder=~/Pictures/background/light/*

# select the first line after random sorting
# to get a random image from that folder
image=$(ls $folder | sort -R | head -n 1)

# change the background and the color scheme
wal -i "$image"
