local M = {}

M.P = function(v)
  print(vim.inspect(v))
  return v
end

_G.P = M.P

return M
