-- Ensure language servers and tools are installed via Mason
require("mason").setup()

require("mason-tool-installer").setup({ ensure_installed = { "prettier", "stylua" } })

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "ruff", "rust_analyzer", "vtsls", "vue_ls" },
    automatic_enable = true,
})
