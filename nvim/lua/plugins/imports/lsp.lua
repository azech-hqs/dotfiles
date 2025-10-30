return {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim", version = "*" },
            { "mason-org/mason-lspconfig.nvim", version = "*" },
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", version = "1.*", opts = {} },
        },
        config = function()
            require("plugins.configs.mason")
        end,
    },
    { -- Configure LuaLS for editing nvim config files
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
}
