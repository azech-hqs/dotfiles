-- Context
vim.opt.colorcolumn = "90"      -- str: Show col for max line length
vim.opt.number = true           -- bool: Show line numbers
vim.opt.relativenumber = true   -- bool: Show relative line numbers
vim.opt.cursorline = true       -- bool: Highlight cursor line
vim.opt.scrolloff = 4           -- int: Min num lines of context
vim.opt.signcolumn = "yes"      -- str: Show the sign column   

-- Filetypes
vim.opt.encoding = "utf8"       -- str: String encoding
vim.opt.fileencoding = "utf8"   -- str: File encoding

-- Theme
vim.opt.syntax = "ON"           -- str: Allow syntax highlighting
vim.opt.termguicolors = true    -- bool: If terminal supports ui color then enable

-- Search
vim.opt.ignorecase = true       -- bool: Ignore case in search patterns
vim.opt.smartcase = true        -- bool: Override ignorecase if search contains uppercase
vim.opt.incsearch = true        -- bool: Use incremental search
vim.opt.hlsearch = false        -- bool: Highlight search matches

-- Whitespace
vim.opt.expandtab = true        -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 4          -- num: Size of an indent
vim.opt.softtabstop = 4         -- num: Number of spaces tabs count for in insert mode
vim.opt.tabstop = 4             -- num: Number of spaces tabs count for

-- Splits
vim.opt.splitright = true       -- bool: Place new window to the right of current one
vim.opt.splitbelow = true       -- bool: Place new window below the current one

-- Timings
vim.opt.updatetime = 250        -- int: Milliseconds after which swap file will be written
vim.opt.timeoutlen = 400        -- int: Milliseconds to wait for mapped sequence to complete

-- Other
vim.opt.undofile = true         -- bool: Whether to save undo history

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'
