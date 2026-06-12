# dotfiles

Personal dotfiles for **macOS** and **Ubuntu/Debian**, managed with
[chezmoi](https://www.chezmoi.io/). Each program's configuration lives under
`dot_config/<program>/`, which chezmoi deploys to `~/.config/<program>/`.

## Fresh machine

```sh
git clone https://github.com/azech-hqs/dotfiles.git ~/Development/dotfiles
~/Development/dotfiles/bootstrap.sh
```

`bootstrap.sh` installs chezmoi (Homebrew on macOS, the static-binary installer
on Linux), points it at this repo as its source directory, and runs
`chezmoi apply`. It is safe to re-run.

## Everyday use

This repo is chezmoi's source of truth; chezmoi deploys **copies** into `$HOME`
(not symlinks). Typical workflow:

```sh
chezmoi diff                           # preview pending changes to $HOME
chezmoi apply                          # write changes into $HOME
chezmoi edit ~/.config/nvim/init.lua   # edit the source, then apply
chezmoi re-add                         # pull edits made directly in ~/.config back into the repo
chezmoi cd                             # open a shell in the source repo
```

Because deployed files are copies, edits made directly in `~/.config` must be
captured back with `chezmoi re-add` (or made via `chezmoi edit`).

## Not yet managed

`zsh`/`shell`, per-OS templating, and secrets (SSH keys / API tokens pulled
from KeePassXC and Proton Pass) are work in progress and excluded via
`.chezmoiignore`.

## Links
- https://www.chezmoi.io/
- https://github.com/webpro/awesome-dotfiles
