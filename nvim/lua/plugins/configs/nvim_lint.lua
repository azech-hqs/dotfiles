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
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint(nil, { ignore_errors = true })
    end,
})

-- Keybindings
vim.keymap.set("n", "<leader>cl", require("lint").try_lint, { desc = "[C]ode [L]int buffer" })
