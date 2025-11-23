local rgb = require("ppm.toolkit.color.converters.rgb")

local M = {}

M.to_rgb = function(hex)
  local r, g, b, a = rgb.from_hex(hex)

  return { r, g, b, a }
end

M.pattern = {
  "#%x%x%x%f[^%x%w]",           -- RGB
  "#%x%x%x%x%f[^%x%w]",         -- RGBA
  "#%x%x%x%x%x%x%f[^%x%w]",     -- RRGGGBB
  "#%x%x%x%x%x%x%x%x%f[^%x%w]", -- RRGGGBBAA
}

return M