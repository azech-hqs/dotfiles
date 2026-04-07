return {
    -- QoL improvements
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = require("plugins.configs.snacks").opts,
        keys = require("plugins.configs.snacks").keys,
    },
}
