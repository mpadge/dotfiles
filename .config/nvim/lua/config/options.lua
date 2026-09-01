-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","
vim.g.mapleader = ";"
vim.g.linebreak = 80
vim.g.textwidth = 80

-- https://vi.stackexchange.com/a/39800
-- LazyVim sets a *global* formatexpr (conform.nvim), so buffer-local
-- `= nil` just falls back to that instead of clearing it. Set it to an
-- explicit empty string, on every buffer, so `gq` always uses Vim's
-- internal formatting.
vim.api.nvim_create_autocmd({ 'BufEnter', 'LspAttach' }, {
  callback = function(args)
    vim.bo[args.buf].formatexpr = ''
  end,
})

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
-- Says "disable_automate = true", but
-- https://github.com/LazyVim/LazyVim/blob/8346fa7ddc9390312408be571c6443c0b57b9f21/lua/lazyvim/config/options.lua#L6
-- has option `vim.g.automate = true`, and that works:
vim.g.autoformat = false

vim.opt.relativenumber = false
vim.opt.shiftwidth = 4

-- https://github.com/PMassicotte/loom-lsp
vim.lsp.config("loom-lsp", {
    cmd = { "loom-lsp", "--stdio" },
    filetypes = { "quarto" },
    root_dir = vim.fs.root(0, { ".git", "_quarto.yml" }),
})

vim.lsp.enable("loom-lsp")
vim.treesitter.language.register("javascript", "ojs")
