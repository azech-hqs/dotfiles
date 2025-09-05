---@type blink.cmp.Config
return {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    keymap = {
        preset = "default",
        ["<C-i>"] = { "show_documentation", "hide_documentation" },
        ["<C-h>"] = { "scroll_documentation_down", "fallback" },
        ["<C-g>"] = { "scroll_documentation_up", "fallback" },
    },

    appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- optionally disable cmdline completions
        -- cmdline = {},
    },

    -- experimental signature help support
    signature = { enabled = true },

    completion = {
        menu = {
            auto_show = function(ctx)
                return ctx.mode ~= "cmdline"
                    or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
            end,
        },
    },
}
