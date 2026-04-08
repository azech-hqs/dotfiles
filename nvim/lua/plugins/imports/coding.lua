return {
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    {
        "nvim-mini/mini.surround",
        version = false,
        opts = require("plugins.configs.mini_surround").opts,
    },

    -- Highlight word under cursor
    { "nvim-mini/mini.cursorword", version = false, opts = {} },
}
