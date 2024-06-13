-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://github.com/neovim/nvim-lspconfig/wiki/Toggle-LSP-for-current-buffer:
local toggle_lsp_client = function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if not vim.tbl_isempty(clients) then
        vim.cmd("LspStop")
    else
        vim.cmd("LspStart")
    end
end

vim.keymap.set("n", "<C-L>", toggle_lsp_client)
