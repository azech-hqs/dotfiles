return {
    -- Enhance Neovim's native comments
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = require("plugins.configs.mini_surround").opts,
    },

    -- Highlight word under cursor
    { "nvim-mini/mini.cursorword", version = false, opts = {} },

    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.nvim_lint")
        end,
    },

    -- Jump & Search
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = require("plugins.configs.flash").opts,
        keys = require("plugins.configs.flash").keys,
    },
}
