# STOPGAP: move to provisioning (ansible) when ready.
# Loaded before 20-aliases.zsh so the `cd='z'` alias guard sees `z`.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi
