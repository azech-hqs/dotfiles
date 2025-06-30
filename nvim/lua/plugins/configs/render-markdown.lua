local M = {}

M.opts = {
    completions = { blink = { enabled = true } },
}

M.keys = {
    {
        "<leader>tm",
        function()
            require("render-markdown").buf_toggle()
        end,
        "n",
        desc = "[T]oggle [M]arkdown render",
    },
}

return M
