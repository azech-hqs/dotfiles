vim.pack.add({ "https://github.com/nickjvandyke/opencode.nvim" })

vim.o.autoread = true -- Required for `opts.events.reload`

local opencode = require("opencode")

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
    opencode.ask("@this: ", { submit = true })
end, { desc = "Opencode: [A]sk" })

vim.keymap.set({ "n", "x" }, "<leader>ox", function()
    opencode.select()
end, { desc = "Opencode: E[x]ecute action" })

vim.keymap.set("n", "<leader>ot", function()
    opencode.toggle()
end, { desc = "Opencode: [T]oggle" })

-- Operators
vim.keymap.set({ "n", "x" }, "go", function()
    return opencode.operator("@this ")
end, { desc = "Opencode: Add range", expr = true })
vim.keymap.set("n", "goo", function()
    return opencode.operator("@this ") .. "_"
end, { desc = "Opencode: Add line", expr = true })

-- Scrolling
vim.keymap.set("n", "<S-C-u>", function()
    opencode.command("session.half.page.up")
end, { desc = "Opencode: Scroll up" })
vim.keymap.set("n", "<S-C-d>", function()
    opencode.command("session.half.page.down")
end, { desc = "Opencode: Scroll down" })
