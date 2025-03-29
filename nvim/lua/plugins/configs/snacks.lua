require("snacks").setup({
    ---@type snacks.Config
    bigfile = { enabled = true },
    indent = { enabled = true,
        indent = {
            char = "┊",
        },
        scope = {
            char = "┊",
        },
    },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
})
