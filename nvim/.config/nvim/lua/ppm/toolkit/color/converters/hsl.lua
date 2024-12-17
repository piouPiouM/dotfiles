local M = {}

M.calc_hue = function(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local delta = max - min
  local h = 0

  if max == min then
    h = 0
  elseif max == r then
    h = 60 * ((g - b) / delta)
  elseif max == g then
    h = 60 * ((b - r) / delta + 2)
  elseif max == b then
    h = 60 * ((r - g) / delta + 4)
  end

  if h < 0 then
    h = h + 360
  end

  return { hue = h, max = max, min = min, delta = delta }
end

---@param hex HEX
---@return HSLA
M.from_hex = function(hex)
end

---@param hex HEX
---@return HSLA
M.from_rgba = function(hex)
end

return M