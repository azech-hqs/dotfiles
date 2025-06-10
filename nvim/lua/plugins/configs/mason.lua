-- Ensure language servers and tools are installed via Mason
require("mason").setup()

require("mason-tool-installer").setup({ ensure_installed = { "prettier", "stylua", "isort" } })

require("mason-lspconfig").setup({
    ensure_installed = { "eslint", "gopls", "lua_ls", "pyright", "ruff", "rust_analyzer" },
    automatic_enable = true,
})
