return {
    "stevearc/conform.nvim",
    enabled = false,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            lua = { "stylua" },
            python = { "isort", "black" },
            d2 = { "d2" },
        },
        formatters = {
            d2 = {
                command = "d2",
                args = { "fmt", "$FILENAME" },
                stdin = false,
            },
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
        autoformat = false,
    },
}
