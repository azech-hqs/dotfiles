vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local Snacks = require("snacks")

Snacks.setup({
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
    gh = {},
    image = {},
    input = {},
    explorer = {},
    lazygit = {},
    picker = {},
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {},
})

vim.keymap.set("n", "<leader>tt", function()
    Snacks.terminal.open()
    vim.api.nvim_win_set_height(0, 15)
end, { desc = "[T]erminal" })


-- stylua: ignore start
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })
-- find
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "[F]ind [C]onfig File" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "[F]ind [G]it Files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "[F]ind [P]rojects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "[F]ind [R]ecent" })
-- git
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "[B]ranches" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "[L]og" })
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[L]og Line" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Status" })
vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "[S]tash" })
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "[D]iff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Log [F]ile" })
vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
vim.keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
vim.keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })
-- grep
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "[B]uffer Lines" })
vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open [B]uffers" })
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "[G]rep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or [w]ord" })
-- search
vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "[S]earch History" })
vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "[A]utocmds" })
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "[B]uffer Lines" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "[C]ommand History" })
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "[C]ommands" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "[D]iagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer [D]iagnostics" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[H]elp Pages" })
vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "[H]ighlights" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "[I]cons" })
vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "[J]umps" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[K]eymaps" })
vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "[L]ocation List" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[M]arks" })
vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "[M]an Pages" })
vim.keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "[S]earch for [P]lugin Spec" })
vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "[Q]uickfix List" })
vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "[R]esume" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "[U]ndo History" })
vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "[C]olorschemes" })
-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "[G]oto [D]eclaration" })
vim.keymap.set("n", "gR", function() Snacks.picker.lsp_references() end, { desc = "[R]eferences" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "[G]oto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP [S]ymbols" })
vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace [S]ymbols" })
vim.keymap.set("n", "gk",
        function()
            vim.api.nvim_open_win(0, true, { split = 'right', win = 0 })
            Snacks.picker.lsp_definitions()
        end,
        { desc = "[G]o to definition (new window)"
    })
-- tools
vim.keymap.set("n", "<leader>ul", function() Snacks.lazygit() end, { desc = "[L]azygit"})
--stylua: ignore end
