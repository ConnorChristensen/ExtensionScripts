#!/bin/bash

# Git backup then rebase autosquash interactive: gbrs

# To install on MacOS:
# cd /usr/local/bin
# ln -s /Users/connor/work/code/scripts/git-backup-then-rebase-squash.sh gbrs

# if no arguments provided
if [ $# == 0 ]; then
    echo "You need to provide a branch name!"
    exit 1
fi

gb && git rebase --interactive --autosquash $1
