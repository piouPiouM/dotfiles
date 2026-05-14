local F = require("ppm.toolkit.fp.function")
local A = require("ppm.toolkit.fp.Array")
local map, pipe = F.map, F.pipe

local M = {}

--- Wraps the given string by Lua pattern captures only in "lua" style.
---
---@param capture_style "lua" | "hipatterns"
M.get_capture = function(capture_style)
  return function(str)
    return capture_style == "lua" and "(" .. str .. ")" or str
  end
end

M.build_pattern_chunks = function(capture)
  local pattern = {
    frontier = {
      begin = "%f[%w]",
    },
    number = capture("%d+%.?%d*"),
    separator = {
      modern = "%s+",
      legacy = "%s*,%s*",
    },
  }
  pattern.percent = pattern.number .. "%%?"
  pattern.alpha = {
    modern = "%s*/%s*" .. pattern.percent,
    legacy = pattern.separator.legacy .. pattern.number,
  }

  return pattern
end

---@param capture_style "lua" | "hipatterns"
M.wrap_by_capture = function(capture_style)
  return function(str)
    return capture_style == "hipatterns" and "()" .. str .. "()" or str
  end
end

---@param patterns string[]
M.build_css_pattern = function(patterns)
  local function get_formatter(pattern)
    ---@param flavor "modern" | "legacy"
    return function(flavor)
      ---@param str string
      return function(str)
        return string.format(
          str,
          pattern.frontier.begin,
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

  return function(capture_style)
    local pattern = M.build_pattern_chunks(M.get_capture(capture_style))
    local flavor = get_formatter(pattern)

    return pipe(
      pipe(
        patterns,
        map(flavor("modern"))
      ),
      A.concat(pipe(
        patterns,
        map(flavor("legacy"))
      )),
      map(M.wrap_by_capture(capture_style))
    )
  end
end

return M