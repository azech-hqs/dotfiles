return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    { "echasnovski/mini.surround", version = "*", opts = {} },

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
        config = function()
            require("plugins.configs.cmp")
        end,
    },

    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        -- See `:help indent_blankline.txt`
        opts = {
            indent = { char = "┊" },
        },
    },

}
