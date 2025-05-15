local snacks = require("snacks")
snacks.setup({
    ---@type snacks.Config
    bigfile = { enabled = true },
    indent = {
        enabled = true,
        indent = {
            char = "┊",
        },
        scope = {
            char = "┊",
        },
    },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {},
})

-- Keymaps
local function toggle_term()
    snacks.terminal.open()
    vim.api.nvim_win_set_height(0, 15)
end
vim.keymap.set("n", "<leader>tt", toggle_term, { desc = "[T]oggle [T]erminal}" })
