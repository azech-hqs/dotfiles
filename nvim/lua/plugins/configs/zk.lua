require("zk").setup({
    picker = "snacks_picker",
})

vim.keymap.set("n", "<leader>zn", function()
    require("zk.commands").get("ZkNotes")()
end, { desc = "Open [Z]k [N]otes" })

vim.keymap.set("n", "<leader>zl", function()
    require("zk.commands").get("ZkInsertLink")()
end, { desc = "Insert [Z]k [L]ink" })
