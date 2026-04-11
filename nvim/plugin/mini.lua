vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.cursorword").setup()
require("mini.icons").setup()
require("mini.surround").setup({
    mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = "gl", -- Suffix to search with "prev" method
        suffix_next = "gn", -- Suffix to search with "next" method
    },
})
