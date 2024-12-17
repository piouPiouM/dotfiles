local M = {}

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

---@param hsl HSLA
---@return RGBA
M.from_hsl = function(hsl)

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
M.to_hex = function(r, g, b)
  local rgb = (r * 0x10000) + (g * 0x100) + b

  return string.format("%06x", rgb)
end

return M