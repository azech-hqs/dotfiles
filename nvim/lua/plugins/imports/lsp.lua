---@type LazyPluginSpec[]
return {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
        },
        config = function()
            require("plugins.configs.lspconfig")
        end,
    },
    { -- Configure LuaLS for editing nvim config files
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
}
