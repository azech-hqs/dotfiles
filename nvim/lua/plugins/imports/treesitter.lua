return {
    -- Highlight, edit, and navigate code
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        config = function()
            require("plugins.configs.treesitter")
        end,
    },
    -- Autorename/autoclose HTML tags
    {
        "windwp/nvim-ts-autotag",
        config = function()
            local opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
            }
            require("nvim-ts-autotag").setup({ opts = opts })
        end,
    },
}
