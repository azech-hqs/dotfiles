return {
    -- Markdown rendering
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "saghen/blink.cmp",
            "nvim-mini/mini.icons",
        },
        opts = require("plugins.configs.markview").opts,
    },
}
