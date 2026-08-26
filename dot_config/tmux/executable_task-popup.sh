#!/usr/bin/env bash
# Disposable Taskwarrior popup: renders a report, then accepts Taskwarrior
# commands and re-renders after each one. Bound to <prefix> t in tmux.conf.
#
# Usage: task-popup.sh [report]   (default: today)

set -u
set -o history 2>/dev/null || true # so read -e can recall previous input

REPORT="${1:-today}"

HINT='⏎ refresh · ? help · q quit'

trim() { # strip leading/trailing whitespace from $1
    local s=$1
    s="${s#"${s%%[![:space:]]*}"}"
    s="${s%"${s##*[![:space:]]}"}"
    printf '%s' "$s"
}

show_help() {
    clear
    cat <<'EOF'

  Type anything you would pass to `task`; the leading "task" is optional.

    3 done                    complete task 3
    3 start / 3 stop          toggle active
    add fix flaky CI +today   new task on the Today list
    add review MR +today project:foo workid:ABC-1 mr:!42
    2 mod pri:H               change an attribute
    2 mv.sprint               move Today -> Sprint
    2 mv.backlog              move Today -> Backlog
    2 mv.today                move anything -> Today
    3 annotate waiting on QA  attach a note
    3 delete                  remove it
    undo                      revert the last change

  Reports: today · sprint · backlog · recent
  Open another report directly:  task-popup.sh sprint

EOF
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
    task "$REPORT"
    echo
    printf '  \033[2m%s\033[0m\n' "$HINT"
    [ -n "$status" ] && printf '  %b\n' "$status"
    status=''
    echo

    read -r -e -p 'task ▸ ' input || break # Ctrl-D closes the popup

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
    input="${input#task }" # tolerate muscle-memory "task 3 done"

    echo
    # eval so quoting/attributes behave exactly as they do in a shell; output is
    # left uncaptured so `edit`, `undo` and delete confirmations keep their tty.
    eval "task $input"
    rc=$?

    if [ "$rc" -eq 0 ]; then
        status="\033[32m✓\033[0m \033[2mtask ${input}\033[0m"
    else
        status="\033[31m✗\033[0m \033[2mtask ${input} (exit ${rc})\033[0m"
        pause # keep the error text on screen
    fi
done
