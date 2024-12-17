local F = require("ppm.toolkit.fp.function")

local M = {}

---@section Instances

---@type Eq<string>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Ord<string>
M.Ord = {
  equals = M.Eq.equals,
  compare = function(first, second)
    return first < second and -1 or first > second and 1 or 0
  end
}

---@type Semigroup<string>
M.Semigroup = {
  ---@param first string
  ---@param second string
  ---@return string
  concat = function(first, second)
    return first .. second
  end
}

---@type Monoid<string>
M.Monoid = {
  concat = M.Semigroup.concat,
  empty = ""
}

---@section Utilities

---Replaces matches for `pattern` in `s`tring with `replacement`.
---
---@param pattern string The pattern to replace.
---@param replacement string The match replacement.
---@param n integer? The number of replacement to perform. Default to all.
---@return fun(s: string): string
M.replace = function(pattern, replacement, n)
  return function(s)
    local transformed, _ = string.gsub(s, pattern, replacement, n)

    return transformed
  end
end

--- Replaces the first match for `pattern` in `s`tring with `replacement`.
---
---@param pattern string The pattern to replace.
---@param replacement string The match replacement.
---@return fun(s: string): string
M.replace_first = function(pattern, replacement)
  return M.replace(pattern, replacement, 1)
end

M.to_upper = function()
  return string.upper
end

M.to_lower = function()
  return string.lower
end

--- Removes leading whitespace or specified characters from `s`tring.
---
---@param chars string? The characters to trim.
---@return fun(s: string): string
M.trim_start = function(chars)
  local pattern = type(chars) == "string" and ("^[%s]+"):format(chars) or "^%s+"

  return M.replace(pattern, "")
end

--- Removes trailing whitespace or specified characters from `s`tring.
---
---@param chars string? The characters to trim.
---@return fun(s: string): string
M.trim_end = function(chars)
  local pattern = type(chars) == "string" and ("[%s]+$"):format(chars) or "%s+$"

  return M.replace(pattern, "")
end

--- Removes leading and trailing whitespace or specified characters from `s`tring.
---
---@param chars string? The characters to trim.
---@return fun(s: string): string
M.trim = function(chars)
  return F.compose(M.trim_end(chars), M.trim_start(chars))
end

--- Splits `s`tring by `separator`.
---
---@param separator string The separator pattern to split by.
---@return fun(s: string): string[]
M.split = function(separator)
  local opts = { trimempty = true, plain = false }

  return function(s)
    return vim.split(s, separator, opts)
  end
end

--- Returns an array of the words of the `s`tring.
M.words = M.split("%s+")

--- Checks if `s`tring starts with the given pattern.
---
--- @param pattern string The pattern to search for.
--- @param position integer? The position to search from.
--- @return fun(s: string): boolean
M.starts_with = function(pattern, position)
  return function(s)
    return string.find(s, pattern) == (position or 1)
  end
end

--- Checks if `s`tring ends with the given pattern.
---
--- @param pattern string The pattern to search for.
--- @param position integer? The position to search from.
--- @return fun(s: string): boolean
M.ends_with = function(pattern, position)
  return function(s)
    local _, stop = string.find(s, pattern)

    return stop == (type(position) == "number" and position or #s)
  end
end

M.includes = function(pattern, position)
  return function(s)
    local start = string.find(s, pattern)

    return position >= 1 and start == position or start >= 1
  end
end

M.get_glue_monoid = function(separator)
  local MC = require("ppm.toolkit.fp.Monoid")

  return MC.intercalate(separator)(M.Monoid)
end

--- Converts all elements in `array` into a string separated by `separator`.
---
---@param separator string
---@return fun(array: string[]): string
M.glue = function(separator)
  local MC = require("ppm.toolkit.fp.Monoid")

  return MC.concat_all(M.get_glue_monoid(separator))
end

--- @param pattern string The formatting pattern.
--- @return fun(s: string, ...:string[]): string
M.format = function(pattern)
  return function(...)
    return type(...) == "table" and string.format(pattern, unpack(...)) or string.format(pattern, ...)
  end
end

return M
