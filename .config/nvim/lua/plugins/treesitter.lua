return {
    {
        'nvim-treesitter/nvim-treesitter',
        dev = false,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
        },
        run = ':TSUpdate',
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                ensure_installed = { -- Add more parsers:
                    'bash',
                    'css',
                    'dot',
                    'html',
                    'javascript',
                    'json',
                    'julia',
                    'latex', -- requires tree-sitter-cli (installed automatically via Mason)
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'mermaid',
                    'norg',
                    'python',
                    'query',
                    'regex',
                    'rnoweb',
                    'r',
                    'tsx',
                    'typescript',
                    'vim',
                    'vimdoc',
                    'yaml',
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = 'gnn',
                        node_incremental = 'grn',
                        scope_incremental = 'grc',
                        node_decremental = 'grm',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.inner',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.inner',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end,
  },
}
