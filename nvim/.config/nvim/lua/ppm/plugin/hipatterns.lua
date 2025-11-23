local hi = require("mini.hipatterns")
local icons = require("ppm.ui").icons
local rgb = require("ppm.toolkit.color.converters.rgb")
local hex = require("ppm.toolkit.color.converters.hex")
local hsl = require("ppm.toolkit.color.converters.hsl")

local M = {
  highlighters = {},
}

local function pattern_matcher(full_match, patterns)
  for _, pattern in ipairs(patterns) do
    local matches = { full_match:match(pattern) }
    if #matches > 0 then
      return matches
    end
  end

  return nil
end

-- Returns extmark opts for highlights with virtual inline text.
--
---@param bufnr number
---@param match string
---@param data { from_col: number, full_match: string, hl_group: string, line: number, to_col: number }
---@return table
local extmark_opts_inline = function(bufnr, match, data)
  return {
    virt_text = { { icons.color, data.hl_group } },
    virt_text_pos = 'inline',
    priority = 2000,
    right_gravity = false,
  }
end

M.highlighters.hex_color = {
  pattern = hex.pattern,
  group = function(_, _, data)
    ---@type string
    local match = data.full_match
    local rgb_color = rgb.from_hex(match)
    local hex_color = rgb.to_hex(rgb_color)

    return hi.compute_hex_color_group(hex_color, "fg")
  end,
  extmark_opts = extmark_opts_inline,
}

M.highlighters.hsl_color = {
  pattern = hsl.get_pattern("hipatterns"),
  group = function(_, _, data)
    local _ = {
      from_col = 40,
      full_match = "hsl(0deg 0% 100%)",
      line = 2,
      to_col = 40
    }
    local match = pattern_matcher(data.full_match, hsl.get_pattern("lua"))
    if not match then
      return nil
    end

    ---@type string, string, string, string?
    local nh, ns, nl, na = unpack(match)
    ---@type HSLA
    local hsla_color = {
      hue = tonumber(nh),
      saturation = tonumber(ns),
      lightness = tonumber(nl),
      alpha = tonumber(na)
    }
    local hex_color = hsl.to_hex(hsla_color)

    return hi.compute_hex_color_group(hex_color, "fg")
  end,
  extmark_opts = extmark_opts_inline,
}

return M
