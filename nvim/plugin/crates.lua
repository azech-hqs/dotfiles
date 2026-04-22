vim.pack.add({ "https://github.com/saecki/crates.nvim" })

local crates = require("crates")

crates.setup({})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "Cargo.toml",
    callback = function()
        vim.keymap.set(
            "n",
            "<leader>ct",
            crates.toggle,
            { buffer = true, desc = "[C]rate: [T]oggle" }
        )
        vim.keymap.set(
            "n",
            "<leader>cr",
            crates.reload,
            { buffer = true, desc = "[C]rate: [R]eload data" }
        )

        vim.keymap.set(
            "n",
            "<leader>cv",
            crates.show_versions_popup,
            { buffer = true, desc = "[C]rate: show [V]ersions" }
        )
        vim.keymap.set(
            "n",
            "<leader>cF",
            crates.show_features_popup,
            { buffer = true, desc = "[C]rate: show [F]eatures" }
        )
        vim.keymap.set(
            "n",
            "<leader>cp",
            crates.show_dependencies_popup,
            { buffer = true, desc = "[C]rate: show [D]ependencies" }
        )

        vim.keymap.set(
            "n",
            "<leader>cu",
            crates.update_crate,
            { buffer = true, desc = "[C]rate: [U]pdate" }
        )
        vim.keymap.set(
            "v",
            "<leader>cu",
            crates.update_crates,
            { buffer = true, desc = "[C]rate: [U]pdate" }
        )
        vim.keymap.set(
            "n",
            "<leader>ca",
            crates.update_all_crates,
            { buffer = true, desc = "[C]rate: update [A]ll" }
        )
        vim.keymap.set(
            "n",
            "<leader>cU",
            crates.upgrade_crate,
            { buffer = true, desc = "[C]rate: [U]pgrade" }
        )
        vim.keymap.set(
            "v",
            "<leader>cU",
            crates.upgrade_crates,
            { buffer = true, desc = "[C]rate: [U]pgrade" }
        )
        vim.keymap.set(
            "n",
            "<leader>cA",
            crates.upgrade_all_crates,
            { buffer = true, desc = "[C]rate: upgrade [A]ll" }
        )

        vim.keymap.set(
            "n",
            "<leader>cx",
            crates.expand_plain_crate_to_inline_table,
            { buffer = true, desc = "[C]rate: e[X]pand to table" }
        )
        vim.keymap.set(
            "n",
            "<leader>cX",
            crates.extract_crate_into_table,
            { buffer = true, desc = "[C]rate: e[X]tract to table" }
        )

        vim.keymap.set(
            "n",
            "<leader>cH",
            crates.open_homepage,
            { buffer = true, desc = "[C]rate: open [H]omepage" }
        )
        vim.keymap.set(
            "n",
            "<leader>cR",
            crates.open_repository,
            { buffer = true, desc = "[C]rate: open [R]epository" }
        )
        vim.keymap.set(
            "n",
            "<leader>cD",
            crates.open_documentation,
            { buffer = true, desc = "[C]rate: open [D]ocumentation" }
        )
        vim.keymap.set(
            "n",
            "<leader>cC",
            crates.open_crates_io,
            { buffer = true, desc = "[C]rate: open [C]rates.io" }
        )
        vim.keymap.set(
            "n",
            "<leader>cL",
            crates.open_lib_rs,
            { buffer = true, desc = "[C]rate: open [L]ib.rs" }
        )
    end,
})
