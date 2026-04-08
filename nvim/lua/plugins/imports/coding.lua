return {
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = require("plugins.configs.mini_surround").opts,
    },

    -- Highlight word under cursor
    { "nvim-mini/mini.cursorword", version = false, opts = {} },

    -- Jump & Search
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = require("plugins.configs.flash").opts,
        keys = require("plugins.configs.flash").keys,
    },
}
