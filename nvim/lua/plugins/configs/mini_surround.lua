require("mini.surround").setup()

-- Disable 's' (delete character under cursor)
vim.keymap.set({ "n", "x" }, "s", "<Nop>")
