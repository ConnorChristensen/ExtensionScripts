#!/bin/bash

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)

JOURNAL_PATH="$HOME/work/journal/$YEAR/$MONTH"

TODAYS_JOURNAL=$JOURNAL_PATH/$DAY.md

# check if journal exists for today
if [ ! -f "$TODAYS_JOURNAL" ]; then

  echo "Today's journal was not found."

  cp $JOURNAL_PATH/template.md $JOURNAL_PATH/$DAY.md

  echo "Journal for today was created by copying the template."

  echo "" >> $JOURNAL_PATH/$DAY.md
  bun /Users/connor/work/configs/ExtensionScripts/command_line/scripts/ghPrStatus.ts --format journal >> $JOURNAL_PATH/$DAY.md
fi

# open it in VScode
open $TODAYS_JOURNAL
