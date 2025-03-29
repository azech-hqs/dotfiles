-- Deactivated for now
local builtin = require("statuscol.builtin")

require("statuscol").setup({
    relculright = true,
    segments = {
        {
            sign = {
                namespace = { "gitsign" },
                maxwidth = 1,
                colwidth = 1,
                auto = false,
                fillchar = " ",
                fillcharhl = "StatusColumnSeparator",
            },
            click = "v:lua.ScSa",
        },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
            sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
            sign = {
                name = { ".*" },
                maxwidth = 2,
                colwidth = 1,
                auto = true,
                wrap = true,
            },
            click = "v:lua.ScSa",
        },
        { text = { " " } },
    },
})
