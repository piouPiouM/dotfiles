local M = {}

M.setup = function()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_cursorline_transparent = true
  vim.g.nord_italic = true
end

M.set = function() require("nord").set() end

return M
