#!/usr/bin/env bash
# Disposable zk popup: lists the most recently touched notes, then captures a
# new one or opens an existing one. Bound to <prefix> n in tmux.conf.
#
# Usage: zk-popup.sh [limit]   (default: 8 recent notes)

set -u
set -o history 2>/dev/null || true # so read -e can recall previous input

LIMIT="${1:-8}"

HINT='⏎ new note · /… search · :alias … · @ daily · ? help · q quit'

# zk discovers the notebook on its own, but the `daily` alias in config.toml
# interpolates $ZK_NOTEBOOK_DIR, so resolve it here if the shell has not.
if [ -z "${ZK_NOTEBOOK_DIR:-}" ]; then
    zk_config="${XDG_CONFIG_HOME:-$HOME/.config}/zk/config.toml"
    zk_dir=$(sed -n 's/^[[:space:]]*dir[[:space:]]*=[[:space:]]*"\(.*\)".*/\1/p' "$zk_config" 2>/dev/null | head -1)
    if [ -n "$zk_dir" ]; then
        export ZK_NOTEBOOK_DIR="${zk_dir/#\~/$HOME}"
    fi
fi

# Aliases come from zk itself (global and notebook config merged), so
# machine-specific ones like `meet` or `proj` show up without being listed
# here. One "name<TAB>command" per line; empty if zk or jq is unavailable.
ZK_ALIASES=$(zk config --list aliases --format json --quiet --no-pager 2>/dev/null |
    jq -r 'to_entries[] | "\(.key)\t\(.value)"' 2>/dev/null)

alias_cmd() { # print the command behind zk alias $1, fail if there is none
    [ -n "$1" ] || return 1
    printf '%s\n' "$ZK_ALIASES" |
        awk -F '\t' -v n="$1" '$1 == n { sub(/^[^\t]*\t/, ""); print; f = 1 } END { exit !f }'
}

alias_names() { # ":daily · :pm · …" for the hint line
    printf '%s\n' "$ZK_ALIASES" | cut -f1 | sed '/^$/d; s/^/:/' | paste -sd '\t' - |
        sed 's/\t/ · /g'
}

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
    :<alias>                   run a zk alias from your config
    :<alias> Some title        ... passing the title, if the alias runs zk new
    @                          shortcut for :daily
    q                          quit

EOF
    if [ -n "$ZK_ALIASES" ]; then
        printf '  Aliases:\n'
        printf '%s\n' "$ZK_ALIASES" | awk -F '\t' '{ printf "    :%-22s %s\n", $1, $2 }'
        echo
    fi
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
    names=$(alias_names)
    [ -n "$names" ] && printf '  \033[2maliases  %s\033[0m\n' "$names"
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
    '@' | :*)
        [ "$input" = '@' ] && input=':daily'
        rest=$(trim "${input#:}")
        name=${rest%%[[:space:]]*}
        args=$(trim "${rest#"$name"}")
        label="alias :${name}${args:+ $args}"
        if ! cmd=$(alias_cmd "$name"); then
            printf '  no zk alias named "%s"\n' "$name"
            false
        elif [ "${cmd#zk new}" != "$cmd" ]; then
            # Note-creating aliases take the rest of the line as the title;
            # zk drops it for aliases without $@ (e.g. a --no-input daily).
            if [ -n "$args" ]; then
                zk "$name" --title "$args"
            else
                zk "$name"
            fi
        else
            # shellcheck disable=SC2086 # split on purpose, e.g. `:lucky --limit 3`
            zk "$name" $args
            rc=$?
            # Anything but new/edit prints to the terminal; keep it readable.
            [ "${cmd#zk edit}" = "$cmd" ] && pause
            (exit "$rc")
        fi
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
