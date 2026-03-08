local dap = require("dap")
local dv = require("dap-view")

require("dap-python").setup("uv")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP: Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP: Step out" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>dv", dv.toggle, { desc = "DAP: Toggle view" })
