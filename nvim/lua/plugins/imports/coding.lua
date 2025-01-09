return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    { "echasnovski/mini.surround", version = "*", opts = {} },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        -- use a release tag to download pre-built binaries
        version = "v0.*",
        lazy = false, -- lazy loading handled internally
        dependencies = "rafamadriz/friendly-snippets",
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },
        config = function()
            require("plugins.configs.cmp")
        end,
    },

    -- Add indentation guides even on blank lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        -- See `:help indent_blankline.txt`
        opts = {
            indent = { char = "┊" },
        },
    },

    { -- Linting
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.nvim_lint")
        end,
    },

    { -- Autoformat
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            require("plugins.configs.conform")
        end,
    },
}
