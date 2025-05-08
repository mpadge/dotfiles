local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)

return {

    {
        "R-nvim/R.nvim",
        config = function()
            -- Create a table with the options to be passed to setup()
            local opts = {
                R_args = { "--quiet", "--no-save" },
                hook = {
                    on_filetype = function()
                        -- This function will be called at the FileType event
                        -- of files supported by R.nvim. This is an
                        -- opportunity to create mappings local to buffers.
                        vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
                        vim.api.nvim_buf_set_keymap(0, "v", "<Space>", "<Plug>RSendSelection", {})
                        vim.api.nvim_buf_set_keymap(0, "i", "`", "<Plug>RmdInsertChunk", {})
                        vim.o.foldmethod = "expr"
                        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
                        -- vim.o.foldenable = false
                    end,
                },
                min_editor_width = 72,
                pdfviewer = "/usr/bin/okular",
                rconsole_width = half_width,
                disable_cmds = {
                    "RCustomStart",
                    "RSPlot",
                    "RSaveClose",
                },
                config_tmux = true,
                external_term = "tmux split-window -vh",
            }
            require("r").setup(opts)
        end,
        lazy = false,
    },
}
