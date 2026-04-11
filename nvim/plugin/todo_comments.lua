vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

require("todo-comments").setup()
vim.keymap.set("n", "<leader>st", function()
    require("snacks").picker.todo_comments()
end, { desc = "[To]do" })
