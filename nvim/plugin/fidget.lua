vim.pack.add({
    { src = "https://github.com/j-hui/fidget.nvim", version = vim.version.range("1.x") },
})
require("fidget").setup()
