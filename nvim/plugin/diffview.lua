vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({
    enhanced_diff_hl = true,
    use_icons = true,
})

vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Open diff [v]iew" })
vim.keymap.set(
    "n",
    "<leader>gh",
    "<cmd>DiffviewFileHistory %<cr>",
    { desc = "Open file [h]istory" }
)
vim.keymap.set(
    "n",
    "<leader>gB",
    "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
    { desc = "Review branch changes" }
)
