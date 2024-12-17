local M = {
  highlighters = {},
  inline_text = "󱓻 ", -- "󱓻  "
}

local remove_captures = function(pattern)
  return pattern
      :gsub("%%%(", "@open@")
      :gsub("%%%)", "@close@")
      :gsub("%(", "")
      :gsub("%)", "")
      :gsub("@open@", "%%(")
      :gsub("@close@", "%%)")
end

-- Returns extmark opts for highlights with virtual inline text.
--
---@param data table Includes `hl_group`, `full_match` and more.
---@return table
local extmark_opts_inline = function(_, _, data)
  return {
    virt_text = { { M.inline_text, data.hl_group } },
    virt_text_pos = 'inline',
    priority = 2000,
    right_gravity = false,
  }
end

-- Returns hex color group for matching long hex color.
M.highlighters.hex_color = require("mini.hipatterns").gen_highlighter.hex_color({
  priority = 2000,
  style = "inline",
  inline_text = M.inline_text
})

-- Returns hex color group for matching short hex color.
M.highlighters.hex_short_color = {
  pattern = "#%x%x%x%f[^%x%w]",
  group = function(_, _, data)
    local hi = require("mini.hipatterns")

    ---@type string
    local match = data.full_match
    local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
    local hex_color = "#" .. r .. r .. g .. g .. b .. b

    return hi.compute_hex_color_group(hex_color, "fg")
  end,
  extmark_opts = extmark_opts_inline,
}

-- Returns hex color group for matching hsl() color.
M.highlighters.hsl_color = {
  pattern = "hsl%(%d+%.?%d*deg,? %d+%.?%d*%%?,? %d+%.?%d*%%?%)",
  group = function(_, match)
    local hi = require("mini.hipatterns")
    local utils = require("ppm.colors")

    --- @type string, string, string
    local nh, ns, nl = match:match("hsl%((%d+%.?%d*)deg,? (%d+%.?%d*)%%?,? (%d+%.?%d*)%%?%)")
    local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
    local hex_color = utils.hslToHex(h, s, l)

    return hi.compute_hex_color_group(hex_color, "fg")
  end,
  extmark_opts = extmark_opts_inline,
}

return M
