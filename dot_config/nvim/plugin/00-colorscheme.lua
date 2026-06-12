vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
require("catppuccin").setup({
    flavour = "macchiato",
    integrations = { blink_cmp = true },
})
vim.cmd.colorscheme("catppuccin")
