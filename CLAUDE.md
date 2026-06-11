# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a personal dotfiles repository on macOS. Each top-level directory holds the
configuration for one program (`nvim`, `zsh`, `tmux`, `ghostty`, `kitty`, `wezterm`,
`bat`, `eza`, `zk`, `task`, `tmux-sessionizer`, `shell`). There is no build step.

## Conventions

- **Commits**: Conventional Commits, where the scope is the program the change applies to,
  i.e. the top-level directory name. Examples: `fix(nvim): ...`, `feat(zsh): ...`,
  `chore(tmux): ...`.
- **Lua formatting**: StyLua, configured in `nvim/.stylua.toml` (4-space indent, 99 column
  width, double quotes). Run `stylua nvim/` to format.

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

The Neovim config (`nvim/`) is the most involved part and uses **native Neovim tooling, not a
plugin-manager framework like lazy.nvim**. Understanding the loading model matters before
editing:

- **Entry point**: `nvim/init.lua` sets the leader (`,`) and requires `opts`, `keymaps`, and
  `core.lsp` (from `nvim/lua/`).
- **Plugins**: each file in `nvim/plugin/` is auto-sourced by Neovim at startup (no explicit
  require needed). The convention is one file per plugin that calls `vim.pack.add({ ... })`
  (Neovim's built-in package manager) and then configures it. Numeric prefixes
  (`00-colorscheme.lua`, `01-dependencies.lua`) force load order; `01-dependencies.lua` holds
  shared libraries (plenary, devicons, treesitter helpers) that other plugin files rely on.
  Versions are pinned in `nvim/nvim-pack-lock.json`.
- **LSP**: uses the native `vim.lsp` API (Neovim 0.11+), not `nvim-lspconfig`'s setup calls.
  `nvim/lua/core/lsp.lua` calls `vim.lsp.enable({...})` with a list of server names and defines
  the shared `LspAttach` keymaps and diagnostic UI. Each enabled server is configured by a file
  named after it in `nvim/lsp/<server>.lua` (e.g. `pyright.lua`, `ruff.lua`, `vtsls.lua`,
  `lua_ls.lua`), which Neovim auto-discovers by filename. Some servers in the enable list
  (`vue_ls`, `rust_analyzer`) have no local file and fall back to `nvim-lspconfig` defaults.

To add an LSP server: add its name to the list in `core/lsp.lua`, and optionally create
`nvim/lsp/<name>.lua` for custom settings.
