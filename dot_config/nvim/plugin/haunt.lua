vim.pack.add({ "https://github.com/TheNoeTrevino/haunt.nvim" })

local haunt = require("haunt")
local haunt_api = require("haunt.api")
local haunt_picker = require("haunt.picker")
local prefix = "<leader>n"

haunt.setup({
    sign = "󱙝",
    sign_hl = "DiagnosticInfo",
    virt_text_hl = "HauntAnnotation", -- links to DiagnosticVirtualTextHint
    annotation_prefix = " 󰆉 ",
    annotation_suffix = "",
    line_hl = nil,
    virt_text_pos = "eol",
    above = 80,
    above_border = "rounded", -- "single", "double", "none", or character array
    data_dir = nil,
    per_branch_bookmarks = true,
    picker = "snacks", -- "auto", "snacks", "telescope", or "fzf"
    picker_keys = { -- picker agnostic, we got you covered
        delete = { key = "d", mode = { "n" } },
        edit_annotation = { key = "a", mode = { "n" } },
    },
})

-- Recommended keymaps, with a helpful prefix alias.
-- annotations
vim.keymap.set("n", prefix .. "a", function()
    haunt_api.annotate()
end, { desc = "Annotate" })

vim.keymap.set("n", prefix .. "t", function()
    haunt_api.toggle_annotation()
end, { desc = "Toggle annotation" })

vim.keymap.set("n", prefix .. "T", function()
    haunt_api.toggle_all_lines()
end, { desc = "Toggle all annotations" })

vim.keymap.set("n", prefix .. "d", function()
    haunt_api.delete()
end, { desc = "Delete bookmark" })

vim.keymap.set("n", prefix .. "C", function()
    haunt_api.clear_all()
end, { desc = "Delete all bookmarks" })

-- move
vim.keymap.set("n", prefix .. "p", function()
    haunt_api.prev()
end, { desc = "Previous bookmark" })

vim.keymap.set("n", prefix .. "n", function()
    haunt_api.next()
end, { desc = "Next bookmark" })

-- picker
vim.keymap.set("n", "<leader>sn", function()
    haunt_picker.show()
end, { desc = "A[n]notations (haunt.nvim)" })

-- quickfix
vim.keymap.set("n", prefix .. "q", function()
    haunt_api.to_quickfix()
end, { desc = "Send Hauntings to QF Lix (buffer)" })

vim.keymap.set("n", prefix .. "Q", function()
    haunt_api.to_quickfix({ current_buffer = true })
end, { desc = "Send Hauntings to QF Lix (all)" })

-- yank
vim.keymap.set("n", prefix .. "y", function()
    haunt_api.yank_locations({ current_buffer = true })
end, { desc = "Send Hauntings to Clipboard (buffer)" })

vim.keymap.set("n", prefix .. "Y", function()
    haunt_api.yank_locations()
end, { desc = "Send Hauntings to Clipboard (all)" })
