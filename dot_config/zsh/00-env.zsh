# Machine-agnostic environment.
#
# Tool-specific shell glue (PATH entries, init/eval lines) lives in the
# 10-*.zsh drop-ins so it can be managed per-machine by provisioning.

# VCS
export GIT_EDITOR=nvim
export SVN_EDITOR=nvim

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Taskwarrior
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$PATH"
