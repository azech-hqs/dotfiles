return {
    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "macchiato",
            integrations = { blink_cmp = true },
        },
    },
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        priority = 10, -- Low priority to catch other plugins' keybindings
        opts = require("plugins.configs.tiny_glimmer").opts,
        keys = require("plugins.configs.tiny_glimmer").keys,
    },
}
