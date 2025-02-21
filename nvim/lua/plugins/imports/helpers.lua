return {
    -- Show key bindings
    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.configs.which_key")
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("plugins.configs.snacks")
        end
    },
}
