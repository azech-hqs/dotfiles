local M = {}

-- Config
---@type snacks.Config
M.opts = {
    bigfile = { enabled = true },
    indent = {
        enabled = true,
        indent = {
            char = "┊",
        },
        scope = {
            char = "┊",
        },
    },
    image = {},
    input = {},
    explorer = {},
    lazygit = {},
    picker = {},
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {},
}

-- Keymaps
---@type LazyKeysSpec[]
M.keys = {
    -- snacks.terminal
    {
        "<leader>tt",
        function()
            require("snacks").terminal.open()
            vim.api.nvim_win_set_height(0, 15)
        end,
        "n",
        desc = "[T]erminal",
    },
    -- snacks.picker
    -- stylua: ignore start
    -- Top Pickers & Explorer
    -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader><space>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[F]ind [C]onfig File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "[F]ind [F]iles" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "[F]ind [G]it Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "[F]ind [P]rojects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "[F]ind [R]ecent" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "[B]ranches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "[L]og" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "[L]og Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "[S]tash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "[D]iff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Log [F]ile" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "[B]uffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open [B]uffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[G]rep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or [w]ord", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "[S]earch History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[A]utocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "[B]uffer Lines" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[C]ommand History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "[C]ommands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[D]iagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer [D]iagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[H]elp Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[H]ighlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "[I]cons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "[J]umps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[K]eymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[L]ocation List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "[M]arks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "[M]an Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[S]earch for [P]lugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[Q]uickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "[R]esume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[U]ndo History" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "[C]olorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[G]oto [D]eclaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[R]eferences" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "[G]oto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP [S]ymbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace [S]ymbols" },
    { "gk",
        function()
            vim.api.nvim_open_win(0, true, { split = 'right', win = 0 })
            Snacks.picker.lsp_definitions()
        end,
        desc = "[G]o to definition (new window)"
    },
    -- snacks.lazygit
    { "<leader>ul", function() Snacks.lazygit() end, desc = "[L]azygit"},
    --stylua: ignore end
}

return M
