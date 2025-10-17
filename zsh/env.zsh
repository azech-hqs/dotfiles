# VCS
export GIT_EDITOR=nvim
export SVN_EDITOR=nvim

# XDG
export XDG_CONFIG_HOME=$HOME/.config

# Taskwarrior
export TASKRC=$XDG_CONFIG_HOME/taskwarrior/taskrc

# PATH
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$PATH

# Workaround for uv issue with creating a virtual environment.
# See also: https://github.com/astral-sh/uv/issues/8821
# If uv is installed, the workaround is applied.
if command -v uv &> /dev/null; then
    export PATH="$(dirname "$(realpath "$(which python)")"):$PATH"
fi
