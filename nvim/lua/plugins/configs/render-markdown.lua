local rmd = require("render-markdown")

rmd.setup({
    completions = { blink = { enabled = true } },
})

vim.keymap.set("n", "<leader>tm", function()
    rmd.buf_toggle()
end, { desc = "[T]oggle [M]arkdown render" })
