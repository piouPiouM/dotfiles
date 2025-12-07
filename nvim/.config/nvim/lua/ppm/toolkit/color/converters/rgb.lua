local patterns = require("ppm.toolkit.color.patterns")

local PATTERNS = {
  "%srgba?%%(%sdeg%s%s%s%s%%)",
  "%srgba?%%(%s%s%s%s%s%%)",
  "%srgba?%%(%sdeg%s%s%s%s%s%%)",
  "%srgba?%%(%s%s%s%s%s%s%%)",
}

local M = {}

M.get_pattern = patterns.build_css_pattern(PATTERNS)

---@param hex HEX
---@return RGBA
M.from_hex = function(hex)
  hex = hex:lower():gsub("#", "")

  if #hex == 3 or #hex == 4 then
    hex = hex:gsub("(%x)(%x)(%x)(%x?)", "%1%1%2%2%3%3%4%4")
  end

  return {
    red = tonumber("0x" .. hex:sub(1, 2)),
    green = tonumber("0x" .. hex:sub(3, 4)),
    blue = tonumber("0x" .. hex:sub(5, 6)),
    alpha = #hex == 8 and tonumber("0x" .. hex:sub(7, 8)) / 255 * 100 or 100
  }
end

-- Converts HSL to RGB.
-- https://www.w3.org/TR/css-color-3/#hsl-color
--
---@param hsl HSLA
---@return RGBA
M.from_hsl = function(hsl)
  local h, s, l = hsl.hue % 360, hsl.saturation / 100, hsl.lightness / 100

  if h < 0 then
    h = h + 360
  end

  local function f(n)
    local k = (n + h / 30) % 12
    local a = s * math.min(l, 1 - l)

    return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
  end

  return {
    red = f(0) * 255,
    green = f(8) * 255,
    blue = f(4) * 255
  }
end

-- EXPLANATION:
-- The integer form of RGB is 0xRRGGBB
-- Hex for red is 0xRR0000
-- Multiply red value by 0x10000(65536) to get 0xRR0000
-- Hex for green is 0x00GG00
-- Multiply green value by 0x100(256) to get 0x00GG00
-- Blue value does not need multiplication.

-- Final step is to add them together
-- (r * 0x10000) + (g * 0x100) + b =
-- 0xRR0000 +
-- 0x00GG00 +
-- 0x0000BB =
-- 0xRRGGBB
---@param rgba RGBA
M.to_hex = function(rgba)
  local rgb = (rgba.red * 0x10000) + (rgba.green * 0x100) + rgba.blue

  return string.format("#%06x", rgb)
end

return M