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
        },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
        autoformat = false,
    },
}
