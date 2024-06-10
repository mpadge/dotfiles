vim.g.mapleader = ";"
vim.g.maplocalleader = ","

local width = vim.api.nvim_win_get_width(0)
local width_float = tonumber(vim.fn.str2float(tostring(width)))
local half_width = math.floor(width_float / 2)
os.execute("export R_rconsole_width=" .. tostring(half_width))

return {
  { "jalvesaq/Nvim-R" },
  { "jalvesaq/cmp-nvim-r" },

  require("cmp").setup({
    sources = {
      { name = "cmp_nvim_r" },
    },
  }),
}
