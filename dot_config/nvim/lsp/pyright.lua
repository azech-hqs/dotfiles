-- Parts taken from nvim-lspconfig
local function set_python_path(path)
    local clients = vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
        name = "pyright",
    })
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python =
                vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend(
                "force",
                client.config.settings,
                { python = { pythonPath = path } }
            )
        end
        client.notify("workspace/didChangeConfiguration", { settings = nil })
    end
end

local function resolve_python_path(workspace_dir)
    local conda_prefix = os.getenv("CONDA_PREFIX")
    if conda_prefix and conda_prefix ~= "" then
        local conda_python = conda_prefix .. "/bin/python"
        if vim.uv.fs_stat(conda_python) then
            return conda_python
        end
    end

    local virtual_env = os.getenv("VIRTUAL_ENV")
    if virtual_env and virtual_env ~= "" then
        local venv_python = virtual_env .. "/bin/python"
        if vim.uv.fs_stat(venv_python) then
            return venv_python
        end
    end
    for _, dir_name in ipairs({ ".venv", "venv" }) do
        local candidate = workspace_dir .. "/" .. dir_name .. "/bin/python"
        if vim.uv.fs_stat(candidate) then
            return candidate
        end
    end

    if vim.fn.executable("uv") == 1 then
        local result = vim.system({ "uv", "python", "find" }, { cwd = workspace_dir, text = true })
            :wait()
        if result.code == 0 and result.stdout then
            local uv_python = vim.trim(result.stdout)
            if uv_python ~= "" and vim.uv.fs_stat(uv_python) then
                return uv_python
            end
        end
    end

    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
end

return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- autoSearchPaths = true,
                -- useLibraryCodeForTypes = true,
                -- diagnosticMode = "openFilesOnly",
                ignore = { "*" },
            },
        },
    },
    on_init = function(client)
        local root = client.root_dir or vim.fn.getcwd()
        local python_path = resolve_python_path(root)

        client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
            python = { pythonPath = python_path },
        })
        client:notify("workspace/didChangeConfiguration", { settings = nil })

        vim.notify("Pyright → " .. python_path, vim.log.levels.INFO)
    end,
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
            client:exec_cmd({
                command = "pyright.organizeimports",
                arguments = { vim.uri_from_bufnr(bufnr) },
            })
        end, {
            desc = "Organize Imports",
        })
        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
            desc = "Reconfigure pyright with the provided python path",
            nargs = 1,
            complete = "file",
        })
    end,
}
