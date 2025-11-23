local F = require("ppm.toolkit.fp.function")
local A = require("ppm.toolkit.fp.Array")
local map, pipe = F.map, F.pipe
local rgb = require("ppm.toolkit.color.converters.rgb")

local PATTERNS = {
  "%shsla?%%(%sdeg%s%s%s%s%%)",
  "%shsla?%%(%s%s%s%s%s%%)",
  "%shsla?%%(%sdeg%s%s%s%s%s%%)",
  "%shsla?%%(%s%s%s%s%s%s%%)",
}

local M = {}

--- Wraps the given string by Lua pattern captures only in "lua" style.
---
---@param style "lua" | "hipatterns"
local function get_capture(style)
  return function(str)
    return style == "lua" and "(" .. str .. ")" or str
  end
end

local function build_pattern_chunks(capture)
  local pattern = {
    frontier = {
      b = "%f[%w]",
      e = "%f[%W]",
    },
    number = capture("%d+%.?%d*"),
    separator = {
      modern = "%s+",
      legacy = "%s*,%s*",
    }
  }
  pattern.percent = pattern.number .. "%%?"
  pattern.alpha = {
    modern = "%s*/%s*" .. pattern.percent,
    legacy = pattern.separator.legacy .. pattern.number,
  }

  return pattern
end

local function wrap_by_capture(capture_style)
  return function(str)
    return capture_style == "hipatterns" and "()" .. str .. "()" or str
  end
end

local function get_formatter(pattern)
  ---@param flavor "modern" | "legacy"
  return function(flavor)
    return function(str)
      return string.format(
        str,
        pattern.frontier.b,
        pattern.number,
        pattern.separator[flavor],
        pattern.percent,
        pattern.separator[flavor],
        pattern.percent,
        pattern.alpha[flavor]
      )
    end
  end
end

---@param capture_style "lua" | "hipatterns"
M.get_pattern = function(capture_style)
  local capture = get_capture(capture_style)
  local pattern = build_pattern_chunks(capture)
  local flavor = get_formatter(pattern)

  return pipe(
    pipe(
      PATTERNS,
      map(flavor("modern"))
    ),
    A.concat(pipe(
      PATTERNS,
      map(flavor("legacy"))
    )),
    map(wrap_by_capture(capture_style))
  )
end

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
