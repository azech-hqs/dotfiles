-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize splits
vim.keymap.set("n", "<M-t>", "<c-w>5<", { desc = "Decrease split width for current buffer" })
vim.keymap.set("n", "<M-s>", "<c-w>5>", { desc = "Increase split width for current buffer" })
vim.keymap.set("n", "<M-g>", "<C-W>+", { desc = "Increase split height for current buffer" })
vim.keymap.set("n", "<M-h>", "<C-W>->", { desc = "Decrease split height for current buffer" })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to clipboard (combine with vimotions)" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy until end of line to clipboard" })

-- Paste from clipboard
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from clipboard (on-cursor)" })

-- Select string without leading whitespace for va" or va'
vim.keymap.set("o", "a'", "2i'", { noremap = true })
vim.keymap.set("o", 'a"', '2i"', { noremap = true })
vim.keymap.set("x", "a'", "2i'", { noremap = true })
vim.keymap.set("x", 'a"', '2i"', { noremap = true })

-- Copy current buffer path to clipboard
local function get_buf_path()
    local name = vim.api.nvim_buf_get_name(0)
    print(name)
    vim.fn.setreg("+", name)
end
vim.keymap.set(
    "n",
    "<leader>bp",
    get_buf_path,
    { desc = "Copy current [b]uffer [p]ath to clipboard" }
)

-- Search within selection
-- Note: this overrides standard behavior (extending selection to next found item).
vim.keymap.set("x", "/", "<C-\\><C-n>`</\\%V", { desc = "Search forward within visual selection" })
vim.keymap.set(
    "x",
    "?",
    "<C-\\><C-n>`>?\\%V",
    { desc = "Search backward within visual selection" }
)

-- Toggle checkboxes in markdown: `[ ]` todo, `[/]` ongoing, `[x]` done
-- TODO: find better implementation for filetype-specific keymap
local checkbox_pattern = "^(%s*[%-%*] %[)([x/%s]+)(%])"

---Set the state of every checkbox in a line range. The new state is derived from the first
---checkbox found, so a mixed range ends up uniform.
---@param mode string "visual" for the last visual selection, otherwise the last operator motion
---@param next_state fun(current: string): string
local function set_checkboxes(mode, next_state)
    if vim.bo.filetype ~= "markdown" then
        print("not markdown")
        return
    end
    local first = vim.api.nvim_buf_get_mark(0, mode == "visual" and "<" or "[")[1]
    local last = vim.api.nvim_buf_get_mark(0, mode == "visual" and ">" or "]")[1]

    local filler = nil
    for lnum = first, last do
        local line = vim.fn.getline(lnum)
        local _, state = line:match(checkbox_pattern)
        if state then
            filler = filler or next_state(state)
            vim.fn.setline(lnum, (line:gsub(checkbox_pattern, "%1" .. filler .. "%3")))
        end
    end
end

-- `[x]` <-> `[ ]` (an ongoing `[/]` becomes done)
_G.toggle_checkbox = function(mode)
    set_checkboxes(mode, function(state)
        return state == "x" and " " or "x"
    end)
end

-- `[/]` <-> `[ ]` (a done `[x]` becomes ongoing)
_G.toggle_checkbox_ongoing = function(mode)
    set_checkboxes(mode, function(state)
        return state == "/" and " " or "/"
    end)
end
vim.keymap.set(
    "n",
    "<leader>x",
    ":set opfunc=v:lua.toggle_checkbox<CR>g@",
    { silent = true, desc = "Toggle checkbox" }
)
vim.keymap.set(
    "x",
    "<leader>x",
    ":<C-U>:lua toggle_checkbox('visual')<CR>",
    { silent = true, desc = "Toggle checkbox" }
)
vim.keymap.set(
    "n",
    "<leader>xx",
    "<leader>x_",
    { desc = "Toggle checkbox (current line)", remap = true }
)
vim.keymap.set(
    "n",
    "<leader>xh",
    ":set opfunc=v:lua.toggle_checkbox_ongoing<CR>g@_",
    { silent = true, desc = "Toggle checkbox ongoing/[h]alf (current line)" }
)

-- Substitute the word under the cursor in the whole buffer (rename without LSP).
-- Prefills the replacement with the current word; `\<\>` matches whole words only and
-- `I` makes the match case-sensitive regardless of 'ignorecase'.
vim.keymap.set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[R]ename [w]ord under cursor (substitute)" }
)

-- Undotree toggle
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>ut", function()
    require("undotree").open({
        command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
    })
end, { desc = "[U]ndotree toggle" })

-- Invert word toggle
local function toggle()
    local toggles = {
        ["true"] = "false",
        ["True"] = "False",
        ["always"] = "never",
        ["yes"] = "no",
        ["1"] = "0",
        ["on"] = "off",
        ["&&"] = "||",
        ["+"] = "-",
        ["<"] = ">",
        ["<="] = ">=",
        ["let"] = "const",
    }

    local cword = vim.fn.expand("<cword>")
    local newWord
    for word, opposite in pairs(toggles) do
        if cword == word then
            newWord = opposite
        end
        if cword == opposite then
            newWord = word
        end
    end
    if newWord then
        local prevCursor = vim.api.nvim_win_get_cursor(0)
        vim.cmd.normal({ '"_ciw' .. newWord, bang = true })
        vim.api.nvim_win_set_cursor(0, prevCursor)
    end
end

vim.keymap.set("n", "<leader>tw", toggle, { desc = "[T]oggle [W]ord inverse" })
