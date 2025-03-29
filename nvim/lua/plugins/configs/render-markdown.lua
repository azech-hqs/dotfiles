local rmd = require('render-markdown')

rmd.setup({
    completions = { blink = { enabled = true } },
})

vim.keymap.set("n", "<leader>md", function()
    rmd.buf_toggle()
end, { desc = "Toggle [M]ark[D]own render" })
