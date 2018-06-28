#!/bin/bash
# hide the light widgets in the ui folder
osascript /usr/local/bin/scripts/ui/hideLightWidgets.scpt
# show the dark widgets in the ui folder
osascript /usr/local/bin/scripts/ui/showDarkWidgets.scpt

# get our image folder
folder=~/Pictures/background/dark/*

# select the first line after random sorting
# to get a random image from that folder
image=$(ls $folder | sort -R | head -n 1)

# change the background and the color scheme
wal -i "$image"
