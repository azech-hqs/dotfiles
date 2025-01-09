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

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map(
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            "[D]ocument [S]ymbols"
        )
        map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
        )

        -- See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
    end,
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property "filetypes" to the map in question.
local servers = {
    -- clangd = {},
    gopls = {},
    -- pyright = {},
    rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { "html", "twig", "hbs"} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
    vim.tbl_deep_extend("force", capabilities, require('blink.cmp').get_lsp_capabilities(capabilities))

-- Ensure language servers and tools are installed via Mason
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "ruff",
    "isort",
    "black",
    "stylua", -- Used to format Lua code
    "prettier",
    "eslint_d",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities =
                vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end,
    },
})
