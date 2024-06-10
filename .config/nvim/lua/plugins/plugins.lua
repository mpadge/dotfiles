vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)
-- os.execute("export R_rconsole_width=" .. tostring(half_width))

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
                    end,
                },
                min_editor_width = 72,
                rconsole_width = half_width,
                disable_cmds = {
                    "RClearConsole",
                    "RCustomStart",
                    "RSPlot",
                    "RSaveClose",
                },
            }
            -- Check if the environment variable "R_AUTO_START" exists.
            -- If using fish shell, you could put in your config.fish:
            -- alias r "R_AUTO_START=true nvim"
            if vim.env.R_AUTO_START == "true" then
                opts.auto_start = 1
                opts.objbr_auto_start = true
            end
            require("r").setup(opts)
        end,
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
            })
        end,
    },
    "R-nvim/cmp-r",
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("cmp").setup({ sources = { { name = "cmp_r" } } })
            require("cmp_r").setup({})
        end,
    },
}
