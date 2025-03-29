-- Set leader key
vim.g.mapleader = ","
vim.g.localleader = ","
vim.g.have_nerd_font = true

-- Imports
require("opts")
require("keymaps")
require("ui")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- require("plugins")
require("lazy").setup("plugins.imports")

-- Colorscheme
vim.cmd.colorscheme("catppuccin")
