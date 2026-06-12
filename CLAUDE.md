# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a personal dotfiles repository for macOS and Ubuntu/Debian, managed with
[chezmoi](https://www.chezmoi.io/). Program configs live under `dot_config/<program>/`
(`nvim`, `tmux`, `ghostty`, `kitty`, `wezterm`, `bat`, `eza`, `zk`, `task`,
`tmux-sessionizer`), which chezmoi deploys to `~/.config/<program>/` as copies (not
symlinks). There is no build step. See `README.md` for the bootstrap and everyday
workflow.

chezmoi specifics worth knowing before editing:

- The repo is chezmoi's **source directory**, pinned via `.chezmoi.toml.tmpl`. The
  `dot_` prefix encodes a leading `.`, so `dot_config/nvim/` maps to `~/.config/nvim/`.
- After changing a file under `dot_config/`, run `chezmoi apply` to update `$HOME`
  (deployed files are copies, so the repo and `$HOME` only sync on `apply`/`re-add`).
- `.chezmoiignore` lists paths that must **not** be deployed: repo meta (`README.md`,
  `CLAUDE.md`, `LICENSE`, `prek.toml`, `bootstrap.sh`), the not-yet-migrated `zsh/` and
  `shell/` configs, and TPM-installed tmux plugins.

## Conventions

- **Commits**: Conventional Commits, where the scope is the program the change applies to
  (e.g. the `dot_config/<program>` directory name). Examples: `fix(nvim): ...`,
  `chore(tmux): ...`. Use `chezmoi` as the scope for repo-tooling changes.
- **Lua formatting**: StyLua, configured in `dot_config/nvim/.stylua.toml` (4-space indent,
  99 column width, double quotes). Run `stylua dot_config/nvim/` to format.

## Validation

Hooks are managed by [`prek`](https://github.com/j178/prek) (a pre-commit-compatible runner),
configured in `prek.toml`, and run automatically on commit. To run them manually across the
repo:

```sh
prek run --all-files
```

This runs StyLua plus the builtin hooks (trailing whitespace, end-of-file fixer, large-file
check, TOML/YAML validation, merge-conflict check).

## Neovim architecture

The Neovim config (`dot_config/nvim/`) is the most involved part and uses **native Neovim
tooling, not a plugin-manager framework like lazy.nvim**. Understanding the loading model
matters before editing:

- **Entry point**: `dot_config/nvim/init.lua` sets the leader (`,`) and requires `opts`,
  `keymaps`, and `core.lsp` (from `dot_config/nvim/lua/`).
- **Plugins**: each file in `dot_config/nvim/plugin/` is auto-sourced by Neovim at startup (no
  explicit require needed). The convention is one file per plugin that calls
  `vim.pack.add({ ... })` (Neovim's built-in package manager) and then configures it. Numeric
  prefixes (`00-colorscheme.lua`, `01-dependencies.lua`) force load order; `01-dependencies.lua`
  holds shared libraries (plenary, devicons, treesitter helpers) that other plugin files rely
  on. Versions are pinned in `dot_config/nvim/nvim-pack-lock.json`.
- **LSP**: uses the native `vim.lsp` API (Neovim 0.11+), not `nvim-lspconfig`'s setup calls.
  `dot_config/nvim/lua/core/lsp.lua` calls `vim.lsp.enable({...})` with a list of server names
  and defines the shared `LspAttach` keymaps and diagnostic UI. Each enabled server is configured
  by a file named after it in `dot_config/nvim/lsp/<server>.lua` (e.g. `pyright.lua`, `ruff.lua`,
  `vtsls.lua`, `lua_ls.lua`), which Neovim auto-discovers by filename. Some servers in the enable
  list (`vue_ls`, `rust_analyzer`) have no local file and fall back to `nvim-lspconfig` defaults.

To add an LSP server: add its name to the list in `core/lsp.lua`, and optionally create
`dot_config/nvim/lsp/<name>.lua` for custom settings.
