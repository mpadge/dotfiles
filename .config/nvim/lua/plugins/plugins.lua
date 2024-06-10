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
        dependencies = {
            "hrsh7th/cmp-emoji",
        },
        config = function()
            require("cmp").setup({ sources = { { name = "nvim_lua" } } })
            require("cmp").setup({ sources = { { name = "cmp_r" } } })
            require("cmp_r").setup({})
        end,
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
        end,
    },
    -- change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<localleader>ff",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },
}
