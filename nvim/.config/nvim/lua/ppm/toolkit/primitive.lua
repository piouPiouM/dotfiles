local M = {}

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

return M
