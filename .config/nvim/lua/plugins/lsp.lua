--- https://vi.stackexchange.com/a/45764
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false
            },
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "r", "rmd", "quarto" },
                callback = function(args)
                    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
                end,
            })
        end
    }
}
