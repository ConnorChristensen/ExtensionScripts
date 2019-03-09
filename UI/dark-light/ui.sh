#!/bin/bash

if [ $# == 1 ]; then
   if [ $1 == "-r" ]; then
      osascript -e 'tell application "Übersicht" to refresh'
      exit 0
   elif [ $1 == "--help" ] || [ $1 == "-h" ]; then
      echo "usage: ui [-rldh]"
      echo "-r or --refresh : refresh"
      echo "-l or --light   : light theme"
      echo "-d or --dark    : dark theme"
      echo "-h or --help    : help"
      exit 0
   elif [ $1 == "--light" ] || [ $1 == "-l" ]; then
      # get our image folder
      folder=~/Pictures/background/light/*
   elif [ $1 == "--dark" ] || [ $1 == "-d" ]; then
      folder=~/Pictures/background/dark/*
   fi
fi

# select the first line after random sorting
# to get a random image from that folder
image=$(ls $folder | sort -R | head -n 1)

# change the background and the color scheme
wal -i "$image"

# refresh all widgets
osascript -e 'tell application "Übersicht" to refresh'
