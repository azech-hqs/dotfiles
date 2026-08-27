#!/usr/bin/env sh
#
# Install the tmux plugins that chezmoi does not deploy as dotfiles.
#
# tmux.conf `run`s these from ~/.config/tmux/plugins, and .chezmoiignore keeps
# chezmoi's hands off that directory, so something has to put them there. That
# is this script rather than TPM: one manager (chezmoi), one pinned version per
# plugin, checked into git.
#
# chezmoi keys run_once_ scripts on their contents, so bumping a version below
# is enough to make the next `chezmoi apply` re-run this.
set -eu

PLUGIN_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins"

# Clone <url> into $PLUGIN_DIR/<dest> at <tag>, or move an existing checkout
# onto <tag>. Safe to re-run.
install_plugin() {
	url=$1
	dest=$2
	tag=$3
	target="$PLUGIN_DIR/$dest"

	if [ ! -d "$target/.git" ]; then
		echo "==> cloning $dest at $tag"
		rm -rf "$target"
		mkdir -p "$(dirname "$target")"
		git -c advice.detachedHead=false clone --quiet --depth 1 --branch "$tag" "$url" "$target"
		return
	fi

	# Shallow clones only carry the tag they were cloned at, so fetch the
	# pinned one if this checkout has never seen it.
	if ! git -C "$target" rev-parse --quiet --verify "refs/tags/$tag^{commit}" >/dev/null 2>&1; then
		git -C "$target" fetch --quiet --depth 1 origin "refs/tags/$tag:refs/tags/$tag"
	fi

	if [ "$(git -C "$target" rev-parse HEAD)" = "$(git -C "$target" rev-parse "refs/tags/$tag^{commit}")" ]; then
		echo "==> $dest already at $tag"
		return
	fi

	echo "==> updating $dest to $tag"
	git -C "$target" checkout --quiet --detach "refs/tags/$tag"
}

if ! command -v git >/dev/null 2>&1; then
	echo "install-tmux-plugins: git not found, skipping" >&2
	exit 0
fi

install_plugin "https://github.com/catppuccin/tmux.git" "catppuccin/tmux" "v2.3.0"

echo "==> tmux plugins ready. Reload a running server with: tmux source-file ~/.config/tmux/tmux.conf"
