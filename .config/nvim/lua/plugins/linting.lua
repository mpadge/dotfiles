return {
    {
        "dense-analysis/ale",
        enabled = true,
        config = function()
            -- Configuration goes here.
            local g = vim.g

            g.ale_ruby_rubocop_auto_correct_all = 1

            g.ale_linters = {
                ruby = { "rubocop", "ruby" },
                lua = { "lua_language_server" },
                r = { "lintr" },
                markdown = { "vale" },
                text = { "vale" },
            }

            g.ale_r_lintr_lint_package = 0
            g.ale_r_lintr_options = 'lintr::linters_with_defaults(indentation_linter(4),function_left_parentheses_linter=NULL,commented_code_linter=NULL,object_usage_linter=NULL)'
            g.ale_r_styler_options = 'spaceout::spaceout_style'

            -- workaround for https://github.com/REditorSupport/languageserver/issues/766
            g.ale_r_languageserver_cmd = [[
            if (requireNamespace("languageserver", quietly = TRUE)) {
            local({
                patch_to_json <- function() {
                    ns <- asNamespace("languageserver")
                    if (!is.null(self$error)) {
                        payload <- list(jsonrpc = self$jsonrpc, id = self$id, error = self$error)
                    } else {
                        payload <- list(jsonrpc = self$jsonrpc, id = self$id, result = self$result)
                    }
                    get("response_to_json", envir = ns)(payload)
                }
                ns <- asNamespace("languageserver")
                get("Response", envir = ns)$set("public", "to_json", patch_to_json, overwrite = TRUE)
                get("ResponseErrorMessage", envir = ns)$set("public", "to_json", patch_to_json, overwrite = TRUE)
                })
            }
            languageserver::run()
            ]]
        end,
    },
    {
        "mfussenegger/nvim-lint",
        enabled = true,
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
