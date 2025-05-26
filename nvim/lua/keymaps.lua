-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize splits
vim.keymap.set("n", "<M-t>", "<c-w>5<", { desc = "Decrease split width for current buffer" })
vim.keymap.set("n", "<M-s>", "<c-w>5>", { desc = "Increase split width for current buffer" })
vim.keymap.set("n", "<M-g>", "<C-W>+", { desc = "Increase split height for current buffer" })
vim.keymap.set("n", "<M-h>", "<C-W>->", { desc = "Decrease split height for current buffer" })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to clipboard (combine with vimotions)" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy until end of line to clipboard" })

-- Paste from clipboard
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from clipboard (on-cursor)" })

-- Select string without leading whitespace for va" or va'
vim.keymap.set("o", "a'", "2i'", { noremap = true })
vim.keymap.set("o", 'a"', '2i"', { noremap = true })
vim.keymap.set("x", "a'", "2i'", { noremap = true })
vim.keymap.set("x", 'a"', '2i"', { noremap = true })

-- Copy current buffer path to clipboard
local function get_buf_path()
    local name = vim.api.nvim_buf_get_name(0)
    print(name)
    vim.fn.setreg("+", name)
end
vim.keymap.set(
    "n",
    "<leader>bp",
    get_buf_path,
    { desc = "Copy current [b]uffer [p]ath to clipboard" }
)

-- Search within selection
-- Note: this overrides standard behavior (extending selection to next found item).
vim.keymap.set("x", "/", "<C-\\><C-n>`</\\%V", { desc = "Search forward within visual selection" })
vim.keymap.set(
    "x",
    "?",
    "<C-\\><C-n>`>?\\%V",
    { desc = "Search backward within visual selection" }
)
