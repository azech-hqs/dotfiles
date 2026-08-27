vim.filetype.add({
    pattern = {
        [".*%.gitlab%-ci.*%.yaml"] = "yaml.gitlab",
        [".*%.gitlab%-ci.*%.yml"] = "yaml.gitlab",
    },
})
