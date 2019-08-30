#!/bin/bash

if [ $# == 0 ]; then
  echo "Error: Improper number of arguments"
  echo "for help: ui -h"
  exit 1
fi


if [ $1 == "-r" ]; then
  osascript -e 'tell application "Übersicht" to refresh'
  exit 0
elif [ $1 == "--help" ] || [ $1 == "-h" ]; then
  echo "usage: ui [-rldhs]"
  echo "-r or --refresh : refresh"
  echo "-l or --light   : light theme"
  echo "-d or --dark    : dark theme"
  echo "-h or --help    : help"
  echo "-s or --select  : select a specific image based on name"
  exit 0
elif [ $1 == "--light" ] || [ $1 == "-l" ]; then
  # get our image folder
  folder=~/Pictures/background/light/
  osascript -e 'tell application "System Events"
    tell appearance preferences
    set dark mode to false
    end tell
    end tell'
elif [ $1 == "--dark" ] || [ $1 == "-d" ]; then
  folder=~/Pictures/background/dark/
  osascript -e 'tell application "System Events"
    tell appearance preferences
    set dark mode to true
    end tell
    end tell'
fi


# ui -d/-l -s imageName
if [ $# == 3 ]; then
  if [ $2 == "--select" ]; then
    # add imagename to path
    image="${folder}${3}"
  else
   echo "$2 not recognized. Pass --select to select an image"
   exit 1
  fi
else
  # add wildcard to get every file
  folder="${folder}*"
  # select the first line after random sorting
  # to get a random image from that folder
  image=$(ls $folder | sort -R | head -n 1)
  echo $image
fi


# change the background and the color scheme
wal -i "$image"

# temporary MacOS workaround for a pywal bug
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$(cat "$HOME/.cache/wal/wal")\""

# refresh all widgets
osascript -e 'tell application "Übersicht" to refresh'
