return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    {
        "echasnovski/mini.surround",
        version = "*",
        config = function()
            require("plugins.configs.mini_surround")
        end,
    },

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
        version = "v1.*",
        lazy = false, -- lazy loading handled internally
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = require("plugins.configs.cmp"),
        opts_extend = { "sources.default" },
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
