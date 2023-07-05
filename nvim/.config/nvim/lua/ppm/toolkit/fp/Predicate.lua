---@module 'ppm.toolkit.fp.Predicate'

---@alias Predicate<T> fun(a: `T`): boolean

local M = {}

---@generic T
---@param predicate Predicate<T>
---@return fun(value): Predicate<T>
M.neg = function(predicate)
  return function(value)
    return !predicate(value)
  end
end

return M