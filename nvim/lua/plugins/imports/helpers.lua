---@type LazyPluginSpec[]
return {
    -- Show key bindings
    {
        "folke/which-key.nvim",
        opts = require("plugins.configs.which_key"),
    },
    -- QoL improvements
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = require("plugins.configs.snacks").opts,
        keys = require("plugins.configs.snacks").keys,
    },
}
