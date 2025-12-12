#!/usr/bin/env zsh

# Get last daily note path
last_daily=$(zk list meetings/daily --format={{path}} --limit=1 --created-before=today --sort=created)
last_date=$(echo "$last_daily" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')

from_date="${last_date}T00:00:00"

task \
  "( start.before:today and start.after:${from_date} ) or \
   ( end.after:${from_date} and end.before:today )" \
  export \
    | jq -r -f ~/.config/task/tw-md-checklist.jq

