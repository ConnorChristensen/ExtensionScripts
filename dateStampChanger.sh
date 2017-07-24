#!/bin/bash

#this script was built to be able to modify the creation date on files
#there are photos that have incorrect creation dates, and this was the tool
#used to correct it

for f in $(ls); do
    ts="$(GetFileInfo -d "$f")"
    e="$(date -j -f "%m/%d/%Y %H:%M:%S" "$ts" +%s)"
    ((o=60*60*31))
    ((e+=o))
    nd="$(date -r $e "+%m/%d/%Y %H:%M:%S")"
    SetFile -m "$nd" "$f"
    SetFile -d "$nd" "$f"
done
