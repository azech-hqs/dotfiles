#!/usr/bin/env sh
#
# Bootstrap this dotfiles repo on a fresh machine (macOS or Ubuntu/Debian).
#
#   git clone https://github.com/<you>/dotfiles ~/Development/dotfiles
#   ~/Development/dotfiles/bootstrap.sh
#
# Installs chezmoi if needed, points it at this repo, and applies the configs.
# Safe to re-run: chezmoi only changes what differs.
set -eu

# Absolute path to this repo (the chezmoi source directory).
REPO_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

install_chezmoi() {
	if command -v chezmoi >/dev/null 2>&1; then
		return
	fi
	echo "==> installing chezmoi"
	case "$(uname -s)" in
	Darwin)
		if command -v brew >/dev/null 2>&1; then
			brew install chezmoi
			return
		fi
		;;
	Linux) ;;
	*)
		echo "unsupported OS: $(uname -s)" >&2
		exit 1
		;;
	esac
	# Fallback (and default on Linux): official static-binary installer.
	sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
	export PATH="$HOME/.local/bin:$PATH"
}

install_chezmoi

echo "==> initialising chezmoi from $REPO_DIR"
chezmoi init --source "$REPO_DIR"

echo "==> applying dotfiles"
chezmoi apply

echo "==> done. Review with: chezmoi managed | less"
