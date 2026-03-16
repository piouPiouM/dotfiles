local M = {}

M.rgb_to_hex = function(rgb)
  local r, g, b, a = rgb

  return string.format("#%02x%02x%02x%s", r, g, b,
    --this part only shows the alpha channel if it's not 1
    (a ~= 1 and string.format("%02x", math.floor(a * 255)) or ""))
end

M.hsl_to_hex = function(hsl)

end


return M
