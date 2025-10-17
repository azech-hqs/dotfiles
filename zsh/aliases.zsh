# System
alias ..='cd ..'
alias lsg='ls -G'
alias lsl='ls -alh'
alias ls='eza --icons=auto -G'
alias ll='eza --icons=auto --long'
alias la='eza --icons=auto --long --all'
alias llg='eza --icons=auto --long --git-ignore'

# Use zoxide if available.
if command -v z &> /dev/null; then
    alias cd='z'
fi

# Abbreviations
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias lz='lazygit'
