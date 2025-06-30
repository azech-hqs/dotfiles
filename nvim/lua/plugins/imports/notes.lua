return {
    -- Zettelkasten note-taking
    {
        "zk-org/zk-nvim",
        config = function()
            require("plugins.configs.zk")
        end,
    },

    -- Markdown rendering
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
        opts = require("plugins.configs.render-markdown").opts,
        keys = require("plugins.configs.render-markdown").keys,
    },
}
