-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","
vim.g.mapleader = ";"
vim.g.linebreak = 80
vim.g.textwidth = 80

-- https://vi.stackexchange.com/a/39800
-- Use internal formatting for bindings like gq.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
-- ... but that doesn't work, so just need to manually `:set formatexpr=` until better solution found.

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
-- Says "disable_automate = true", but
-- https://github.com/LazyVim/LazyVim/blob/8346fa7ddc9390312408be571c6443c0b57b9f21/lua/lazyvim/config/options.lua#L6
-- has option `vim.g.automate = true`, and that works:
vim.g.autoformat = false

vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
