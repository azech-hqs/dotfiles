vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-tool-installer").setup({ ensure_installed = { "prettier", "stylua" } })
