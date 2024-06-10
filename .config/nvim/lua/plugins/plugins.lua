vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)

vim.api.nvim_create_autocmd("User", {
    callback = function()
        local ok, buf = pcall(vim.api.nvim_win_get_buf, vim.g.coc_last_float_win)
        if ok then
            vim.keymap.set("g", "w", function()
                require("link-visitor").link_under_cursor()
            end, { buffer = buf })
            vim.keymap.set("g", "x", function()
                require("link-visitor").link_near_cursor()
            end, { buffer = buf })
        end
    end,
    pattern = "CocOpenFloat",
})

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
                pdfviewer = "/usr/bin/okular",
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
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-path",
        },
        config = function()
            require("cmp").setup({ sources = { { name = "nvim_lua" } } })
            require("cmp").setup({ sources = { { name = "cmp_r" } } })
            require("cmp").setup({ sources = { { name = "path" } } })
            require("cmp_r").setup({})
            --- List all language servers with :help lspconfig-all
            require("lspconfig").bashls.setup({})
            require("lspconfig").r_language_server.setup({})
            require("lspconfig").dockerls.setup({
                settings = {
                    docker = {
                        languageserver = {
                            formatter = {
                                ignoreMultilineInstructions = false,
                            },
                        },
                    },
                },
            })
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
    {
        "R-nvim/cmp-r",
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
    {
        "xiyaowong/link-visitor.nvim",
        config = function()
            require("link-visitor").setup({
                open_cmd = nil,
                --[[
          1. cmd to open url
          defaults:
          win or wsl: cmd.exe /c start
          mac: open
          linux: xdg-open
          2. a function to handle the link
          the function signature: func(link: string)
          --]]
                silent = true, -- disable all prints, `false` by defaults skip_confirmation
                skip_confirmation = true, -- Skip the confirmation step, default: false
                border = "rounded", -- none, single, double, rounded, solid, shadow see `:h nvim_open_win()`
            })
        end,
    },
}
