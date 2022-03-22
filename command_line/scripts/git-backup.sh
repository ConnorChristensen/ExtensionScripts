#!/bin/bash

# Git backup: gb

# To install on MacOS:
# cd /usr/local/bin
# ln -s /Users/connor/work/code/scripts/git-backup.sh gb

# get the current time
NOW=$(date +%Y-%m-%d-%H-%M-%S)

# get the name of the current branch
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# make a backup of the branch
git branch "backup/$BRANCH_NAME/$NOW"
