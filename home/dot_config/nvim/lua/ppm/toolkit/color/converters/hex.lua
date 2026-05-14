local M = {}

M.pattern = {
  "#%x%x%x%f[^%x%w]",           -- RGB
  "#%x%x%x%x%f[^%x%w]",         -- RGBA
  "#%x%x%x%x%x%x%f[^%x%w]",     -- RRGGGBB
  "#%x%x%x%x%x%x%x%x%f[^%x%w]", -- RRGGGBBAA
}

return M