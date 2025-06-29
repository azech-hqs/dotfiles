-- Note: nvim-lint complements the built-in language server client for languages where there are no
-- language servers, or where standalone linters provide better results.
local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
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
