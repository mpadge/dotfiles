-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)

return {
    -- ----- colour schemes with optional config::
    { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
    { "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    -- Configure LazyVim to load colour scheme:
    {
        "LazyVim/LazyVim",
        -- opts = {
        --     colorscheme = "catppuccin-latte",
        -- },
        opts = function()
            local colour_scheme_value = os.getenv("NVIM_COLOUR_SCHEME")
            local opts = {}
            if colour_scheme_value ~= "none" then
                opts.colorscheme = colour_scheme_value
            end
            return opts
        end,
    },

    -- add pyright and r_language_server to lspconfig
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                ccls = {},
                pyright = {},
                r_language_server = {
                    cmd = {"R", "--slave", "-e", "languageserver::run()"},
                },
            },
        },
    },

    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "cpp",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "r",
                "regex",
                "rnoweb",
                "tsx",
                "typescript",
                "vim",
                "yaml",
            },
        },
    },

    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- add tsx and treesitter
            vim.list_extend(opts.ensure_installed, {
                "tsx",
                "typescript",
            })
        end,
    },

    -- the opts function can also be used to change the default opts:
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, "😄")
        end,
    },

    -- or you can return new options to override all the defaults
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                --[[add your custom lualine config here]]
            }
        end,
    },

    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
            },
        },
    },

    -- Use <tab> for completion and snippets (supertab)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-emoji",
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
    {
        "R-nvim/cmp-r",
        require("cmp").setup({
            sources = {
                { name = "cmp_r" },
            },
        }),
    },
    -- override nvim-cmp and add extra cmps
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-emoji",
            "R-nvim/cmp-r",
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
            table.insert(opts.sources, { name = "cmp_r" })
        end,
    },
    -- change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            -- add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fp",
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
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {

        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            lspFeatures = {
                enabled = true,
                chunks = 'curly',
            },
            hook = {
                on_filetype = function()
                    local quarto = require("quarto")
                    quarto.setup()
                    vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { silent = true, noremap = true })
                end,
            }
        },
    },

}
