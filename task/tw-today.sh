#!/usr/bin/env zsh

task +PENDING -backlog -sprint export | jq -r -f ~/.config/task/tw-md-checklist.jq
