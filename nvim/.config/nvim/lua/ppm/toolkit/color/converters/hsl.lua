local patterns = require("ppm.toolkit.color.patterns")
local rgb = require("ppm.toolkit.color.converters.rgb")

local PATTERNS = {
  "%shsla?%%(%sdeg%s%s%s%s%%)",
  "%shsla?%%(%s%s%s%s%s%%)",
  "%shsla?%%(%sdeg%s%s%s%s%s%%)",
  "%shsla?%%(%s%s%s%s%s%s%%)",
}

local M = {}

M.get_pattern = patterns.build_css_pattern(PATTERNS)

---@param hex HEX
---@return HSLA
M.from_hex = function(hex)
end

---@param hex HEX
---@return HSLA
M.from_rgba = function(hex)
end

---@param color HSLA
---@return HEX
M.to_hex = function(color)
  return rgb.to_hex(rgb.from_hsl(color))
end

return M