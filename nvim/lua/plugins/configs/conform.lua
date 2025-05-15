require("conform").setup({
    notify_on_error = false,
    format_on_save = nil,
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt"},
        python = { "isort", "ruff_format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
    },
})

vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[C]ode [F]ormat buffer" })
