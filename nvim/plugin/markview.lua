vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })

require("markview").setup({
    preview = {
        icon_provider = "mini", -- "mini", "internal", or "devicons"
    },
    markdown = {
        list_items = {
            shift_width = 2,
            marker_minus = {
                add_padding = false,
            },
            marker_plus = {
                add_padding = false,
            },
            marker_star = {
                add_padding = false,
            },
            marker_dot = {
                add_padding = false,
            },
            marker_parentheses = {
                add_padding = false,
            },
        },
    },
})
