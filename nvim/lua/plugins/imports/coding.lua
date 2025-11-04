return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = require("plugins.configs.mini_surround").opts,
    },

    -- Highlight word under cursor
    { "nvim-mini/mini.cursorword", version = false, opts = {} },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
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

    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.nvim_lint")
        end,
    },

    -- Autoformat
    {
        "stevearc/conform.nvim",
        lazy = false,
        opts = require("plugins.configs.conform").opts,
        keys = require("plugins.configs.conform").keys,
    },

    -- Jump & Search
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = require("plugins.configs.flash").opts,
        keys = require("plugins.configs.flash").keys,
    },

    -- Diagnostics
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup()
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },
}
