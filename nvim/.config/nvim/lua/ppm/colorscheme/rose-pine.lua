local M = {}

M.setup = function()
  require("rose-pine").setup({
    dark_variant = "moon",
    dim_nc_background = true,
    disable_background = true,
  })
end

M.use = function() vim.cmd [[colorscheme rose-pine]] end

return M
