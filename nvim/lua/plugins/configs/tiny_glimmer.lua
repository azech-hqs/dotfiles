local M = {}

M.opts = {
    -- Enable/disable the plugin
    enabled = true,

    -- Disable warnings for debugging highlight issues
    disable_warnings = true,

    -- Animation refresh rate in milliseconds
    refresh_interval_ms = 8,

    -- Automatic keybinding overwrites
    overwrite = {
        -- Automatically map keys to overwrite operations
        -- Set to false if you have custom mappings or prefer manual API calls
        auto_map = true,

        -- Yank operation animation
        yank = {
            enabled = true,
            default_animation = "fade",
        },
        -- Paste operation animation
        paste = {
            enabled = true,
            default_animation = "reverse_fade",
            paste_mapping = "p", -- Paste after cursor
            Paste_mapping = "P", -- Paste before cursor
        },
        -- Undo operation animation
        undo = {
            enabled = true,
            default_animation = {
                name = "fade",
                settings = {
                    from_color = "DiffDelete",
                    max_duration = 500,
                    min_duration = 500,
                },
            },
            undo_mapping = "u",
        },

        -- Redo operation animation
        redo = {
            enabled = true,
            default_animation = {
                name = "fade",
                settings = {
                    from_color = "DiffAdd",
                    max_duration = 500,
                    min_duration = 500,
                },
            },
            redo_mapping = "<c-r>",
        },
    },
}

M.keys = {
    {
        "<leader>H",
        function()
            require("tiny-glimmer.lib").cursor_line("pulse")
        end,
        "n",
        desc = "Animate current line",
    },
}

return M
