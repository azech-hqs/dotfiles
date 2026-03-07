return {
    { -- Configure LuaLS for editing nvim config files
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
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
}
