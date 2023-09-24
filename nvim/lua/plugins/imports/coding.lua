return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            require("plugins.configs.cmp")
        end,
    }
}
