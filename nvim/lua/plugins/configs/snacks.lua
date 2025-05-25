local M = {}

-- Config
---@type snacks.Config
M.opts = {
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
}

-- Keymaps
---@type LazyKeysSpec[]
M.keys = {
    {
        "<leader>tt",
        function()
            require("snacks").terminal.open()
            vim.api.nvim_win_set_height(0, 15)
        end,
        "n",
        desc = "[T]oggle [T]erminal}",
    },
}

return M
