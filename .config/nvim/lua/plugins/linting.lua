return {
    {
        "dense-analysis/ale",
        config = function()
            -- Configuration goes here.
            local g = vim.g

            g.ale_r_lintr_lint_package = 0
            g.ale_r_lintr_options = "lintr::linters_with_defaults(function_left_parentheses_linter=NULL)"
            g.ale_styler_options = "spaceout::spaceout_style"

            g.ale_ruby_rubocop_auto_correct_all = 1

            g.ale_linters = {
                ruby = { "rubocop", "ruby" },
                lua = { "lua_language_server" },
            }
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                cpp = { "cpplint" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                svelte = { "eslint_d" },
                python = { "pylint" },
                json = { "jsonlint" },
                md = { "markdownlint", "textlint", "write-good" },
                txt = { "textlint", "write-good" },
            }
        end,
    },
}
