local M = {}

M.setup = function()
  vim.g.nord_underline_option = "undercurl"
  vim.g.nord_italic = true
  vim.g.nord_italic_comments = true
  vim.g.nord_minimal_mode = false
end

M.set = function() vim.cmd [[colorscheme nordbuddy]] end

return M
