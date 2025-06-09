-- [[ Configure LSP ]]
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        -- See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
    end,
})

-- Ensure language servers and tools are installed via Mason
require("mason").setup()

require("mason-tool-installer").setup({ ensure_installed = { "prettier", "stylua", "isort" } })

require("mason-lspconfig").setup({
    ensure_installed = { "eslint", "gopls", "lua_ls", "pyright", "ruff", "rust_analyzer" },
    automatic_enable = true,
})
