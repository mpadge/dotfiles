vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)
os.execute("export R_rconsole_width=" .. tostring(half_width))

return {
    {
        "R-nvim/R.nvim",
        lazy = false
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function ()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
            })
        end
    },
    "R-nvim/cmp-r",
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("cmp").setup({ sources = {{ name = "cmp_r" }}})
            require("cmp_r").setup({ })
        end,
    },
}
