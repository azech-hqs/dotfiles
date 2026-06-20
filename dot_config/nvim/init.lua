-- Set leader key
vim.g.mapleader = ","
vim.g.localleader = ","
vim.g.have_nerd_font = true

-- Imports
require("opts")
require("keymaps")
require("core.lsp")
