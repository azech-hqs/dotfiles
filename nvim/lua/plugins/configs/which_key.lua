---@class wk.Opts
local M = {
    -- Document existing key chains
    spec = {
        { "<leader>b", group = "[B]uffer" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]oto" },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },
        { "<leader>l", group = "[L]azygit" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>u", group = "[U]tils" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
        { "<leader>z", group = "[Z]k notes" },
        -- visual mode
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
        -- hide checkbox toggle keymap
        { "<leader>x", hidden = true },
    },
}

return M
