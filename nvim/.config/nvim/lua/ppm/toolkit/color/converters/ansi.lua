local colors = {
  ["0;30"] = "#000000", -- black
  ["0;31"] = "#FF0000", -- red
  ["0;32"] = "#00FF00", -- green
  ["0;33"] = "#D2691E", -- brown (dark orange)
  ["0;34"] = "#0000FF", -- blue
  ["0;35"] = "#800080", -- purple
  ["0;36"] = "#00FFFF", -- cyan
  ["0;37"] = "#D3D3D3", -- light_gray
  ["1;30"] = "#808080", -- dark_gray
  ["1;31"] = "#FF5555", -- light_red
  ["1;32"] = "#55FF55", -- light_green
  ["1;33"] = "#FFFF55", -- yellow
  ["1;34"] = "#5555FF", -- light_blue
  ["1;35"] = "#FF55FF", -- light_purple
  ["1;36"] = "#55FFFF", -- light_cyan
  ["1;37"] = "#FFFFFF", -- light_white

  ["1;98"] = "#FFC0CB", -- pink
  ["1;99"] = "#8B0000", -- dark red
  -- High Intensity Colors
  ["0;90"] = "#A9A9A9", -- bright_black (gray)
  ["0;91"] = "#FF5555", -- bright_red
  ["0;92"] = "#55FF55", -- bright_green
  ["0;93"] = "#FFFF55", -- bright_yellow
  ["0;94"] = "#5555FF", -- bright_blue
  ["0;95"] = "#FF55FF", -- bright_purple
  ["0;96"] = "#55FFFF", -- bright_cyan
  ["0;97"] = "#FFFFFF", -- bright_white
  ["0;98"] = "#FFB6C1", -- light pink
  ["0;99"] = "#800000", -- maroon

  ["30"] = "#000000",   -- black
  ["31"] = "#FF0000",   -- red
  ["32"] = "#00FF00",   -- green
  ["33"] = "#D2691E",   -- brown (dark orange)
  ["34"] = "#0000FF",   -- blue
  ["35"] = "#800080",   -- purple
  ["36"] = "#00FFFF",   -- cyan
  ["37"] = "#D3D3D3",   -- light_gray

  ["90"] = "#A9A9A9",   -- bright_black
  ["91"] = "#FF5555",   -- bright_red
  ["92"] = "#55FF55",   -- bright_green
  ["93"] = "#FFFF55",   -- bright_yellow
  ["94"] = "#5555FF",   -- bright_blue
  ["95"] = "#FF55FF",   -- bright_purple
  ["96"] = "#55FFFF",   -- bright_cyan
  ["97"] = "#FFFFFF",   -- bright_white
  ["100"] = "#2F4F4F",  -- dark slate gray
  ["101"] = "#FF4500",  -- orange red
  ["102"] = "#ADFF2F",  -- green yellow
  ["103"] = "#DAA520",  -- goldenrod
  ["104"] = "#4682B4",  -- steel blue
  ["105"] = "#4B0082",  -- indigo
  ["106"] = "#00CED1",  -- dark turquoise
  ["107"] = "#F5F5DC",  -- beige
  ["108"] = "#7FFFD4",  -- aquamarine
  ["109"] = "#DC143C",  -- crimson
  ["110"] = "#9932CC",  -- dark orchid
  ["111"] = "#FFD700",  -- gold
  ["112"] = "#008000",  -- dark green
  ["113"] = "#8B4513",  -- saddle brown
  ["114"] = "#FF6347",  -- tomato
  ["115"] = "#9400D3",  -- dark violet
}

local PATTERNS = {
  "\\033%[()[01];[39]%d()m",
  "\\033%[()[39][0-7]()m",
  "\\033%[()10[0-9]()m",
  "\\033%[()11[0-5]()m",
}

local M = {}

M.get_pattern = function()
  return PATTERNS
end

M.to_hex = function(name)
  return colors[name:lower()]
end

return M
