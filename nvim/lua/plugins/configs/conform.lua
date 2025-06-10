local M = {}

M.opts = {
    notify_on_error = false,
    format_on_save = nil,
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
    },
}

M.keys = {
    {
        "<leader>cf",
        function()
            require("conform").format({ async = true, lsp_fallback = true })
        end,
        "n",
        desc = "[C]ode [F]ormat buffer",
    },
}

return M
