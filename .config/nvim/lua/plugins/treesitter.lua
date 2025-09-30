return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        version = false,
        opts = {
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
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
        },
    }
}
