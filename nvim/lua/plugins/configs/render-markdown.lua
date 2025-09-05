local M = {}

M.opts = {
    enabled = true,
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
