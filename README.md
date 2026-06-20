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

## Shell (zsh)

The shell config is split into modular files under `dot_config/zsh/` (deployed
to `~/.config/zsh/`), loaded in numeric order: `00-env` (machine-agnostic env)
→ `10-*` (per-tool glue) → `20-aliases` → `30-keymaps`.

`~/.zshrc` itself is **not owned** by chezmoi. Instead `modify_dot_zshrc`
injects a single managed block at the end of whatever `~/.zshrc` already exists
on the machine — that block just sources `~/.config/zsh/*.zsh`. Everything
outside the block (oh-my-zsh setup, per-machine `source` lines) is preserved, so
machines with different base `~/.zshrc` files can share these dotfiles.

The `10-*.zsh` files are a **stopgap**: tool installation/PATH/init lines that
will move to a separate provisioning repo (ansible) once it exists, so each tool
brings its own shell glue (and OS-correct paths) when installed. Because
`~/.config/zsh/` is not an `exact_` directory, provisioning can drop additional
`*.zsh` files there without `chezmoi apply` removing them.

## Not yet managed

Per-OS templating and secrets (SSH keys / API tokens pulled from KeePassXC and
Proton Pass) are work in progress.

## Links
- https://www.chezmoi.io/
- https://github.com/webpro/awesome-dotfiles
