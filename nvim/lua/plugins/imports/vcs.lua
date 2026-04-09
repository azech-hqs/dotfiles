return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diff [v]iew" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open file [h]istory" },
            {
                "<leader>gB",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
                desc = "Review branch changes",
            },
        },
        opts = {
            enhanced_diff_hl = true,
            use_icons = true,
        },
    },
}
