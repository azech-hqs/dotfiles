#!/usr/bin/env zsh

task +today export | jq -r -f ~/.config/task/tw-md-checklist.jq
