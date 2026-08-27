#!/usr/bin/env bash
# Disposable zk popup: lists the most recently touched notes, then captures a
# new one or opens an existing one. Bound to <prefix> n in tmux.conf.
#
# Usage: zk-popup.sh [limit]   (default: 8 recent notes)

set -u
set -o history 2>/dev/null || true # so read -e can recall previous input

LIMIT="${1:-8}"

HINT='⏎ new note · /… search · @ daily · ? help · q quit'

# zk discovers the notebook on its own, but the `daily` alias in config.toml
# interpolates $ZK_NOTEBOOK_DIR, so resolve it here if the shell has not.
if [ -z "${ZK_NOTEBOOK_DIR:-}" ]; then
    zk_config="${XDG_CONFIG_HOME:-$HOME/.config}/zk/config.toml"
    zk_dir=$(sed -n 's/^[[:space:]]*dir[[:space:]]*=[[:space:]]*"\(.*\)".*/\1/p' "$zk_config" 2>/dev/null | head -1)
    if [ -n "$zk_dir" ]; then
        export ZK_NOTEBOOK_DIR="${zk_dir/#\~/$HOME}"
    fi
fi

trim() { # strip leading/trailing whitespace from $1
    local s=$1
    s="${s#"${s%%[![:space:]]*}"}"
    s="${s%"${s##*[![:space:]]}"}"
    printf '%s' "$s"
}

show_help() {
    clear
    cat <<'EOF'

  Type a title to capture a new note; it opens in nvim straight away.

    Refactor the auth guard    new note with that title
    new q                      new note titled "q" (escapes the words below)
    /gitlab                    search notes matching "gitlab", pick with fzf
    /                          browse every note with fzf
    @  or  daily               open today's daily note
    q                          quit

EOF
    printf '  Notes land in %s using the default template.\n' \
        "${ZK_NOTEBOOK_DIR:-the notebook zk discovers}"
    printf '  Show more recent notes on open:  zk-popup.sh 20\n\n'
    printf '  \033[2m-- press any key --\033[0m'
    read -rsn1 _
}

pause() {
    printf '\n  \033[2m-- press any key --\033[0m'
    read -rsn1 _
}

status=''

while true; do
    clear
    printf '  \033[2m── recent ──\033[0m\n\n'
    zk list --quiet --sort modified- --limit "$LIMIT" \
        --format "  {{format-date modified '%d.%m.%Y'}}  {{title}}" 2>/dev/null ||
        printf '  \033[31m✗\033[0m could not read the notebook\n'
    echo
    printf '  \033[2m%s\033[0m\n' "$HINT"
    [ -n "$status" ] && printf '  %b\n' "$status"
    status=''
    echo

    read -r -e -p 'note ▸ ' input || break # Ctrl-D closes the popup

    input=$(trim "$input")
    [ -z "$input" ] && continue

    case "$input" in
    q | quit | exit) break ;;
    '?' | h | help)
        show_help
        continue
        ;;
    esac

    history -s "$input" 2>/dev/null

    echo
    case "$input" in
    '@' | daily)
        label='daily note'
        zk daily
        ;;
    /*)
        query=$(trim "${input#/}")
        label="search ${query:-(all)}"
        if [ -n "$query" ]; then
            zk edit --interactive --match "$query"
        else
            zk edit --interactive
        fi
        ;;
    *)
        title="${input#new }" # explicit `new <title>` escapes the words above
        label="new note \"$title\""
        zk new --title "$title"
        ;;
    esac
    rc=$?

    if [ "$rc" -eq 0 ]; then
        status="\033[32m✓\033[0m \033[2m${label}\033[0m"
    else
        status="\033[31m✗\033[0m \033[2m${label} (exit ${rc})\033[0m"
        pause # keep the error text on screen
    fi
done
