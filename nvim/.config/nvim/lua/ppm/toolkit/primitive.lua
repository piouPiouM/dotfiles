local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp.function")
local S = require("ppm.toolkit.fp.string")

local M = {}

---@section Numbers

--- Decrements its argument by 1.
---
---@param n number
---@return number
M.dec = function(n)
  return n - 1
end

--- Increments its argument by 1.
---
---@param n number
---@return number
M.inc = function(n)
  return n + 1
end

--- Checks if its argument is even.
---
---@param n number
---@return boolean
M.even = function(n)
  return n % 2 == 0
end

--- Checks if its argument is odd.
---
---@param n number
---@return boolean
M.odd = function(n)
  return n % 2 == 1
end

---@section Strings

---@param s string
---@return string
M.trim = function(s)
  return S.trim()(s)
end

--- Returns the optional first word of the given string.
---
---@param s string
---@return Option<string>[]
M.first_word = function(s)
  return A.head(S.words(s))
end

--- Returns the optional last word of the given string.
---
---@param s string
---@return Option<string>[]
M.last_word = function(s)
  return A.last(S.words(s))
end

return M