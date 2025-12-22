#!/usr/bin/env zsh

task +today +PENDING export | jq -r -f ~/.config/task/tw-md-checklist.jq
