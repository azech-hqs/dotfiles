local lint = require("lint")

lint.linters_by_ft = {
    python = { "ruff" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})

-- Keybindings
vim.keymap.set("n", "<leader>cl", require("lint").try_lint, { desc = "[C]ode [L]int buffer" })
