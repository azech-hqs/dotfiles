vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.cursorword").setup()
require("mini.icons").setup()

-- Build a surrounding that wraps text in the same string on both sides (e.g. "**").
local function symmetric(str)
    local pat = vim.pesc(str)
    return { input = { pat .. "().-()" .. pat }, output = { left = str, right = str } }
end

require("mini.surround").setup({
    custom_surroundings = {
        B = symmetric("**"), -- markdown bold
        s = symmetric("~~"), -- markdown strikethrough
        w = { -- wiki-link (zk)
            input = { "%[%[().-()%]%]" },
            output = { left = "[[", right = "]]" },
        },
    },
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
