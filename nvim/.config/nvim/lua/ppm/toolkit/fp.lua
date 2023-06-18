--- Utility-belt library for functional programming in Lua ([source](http://github.com/Yonaba/Moses))
-- @author [Roland Yonaba](http://github.com/Yonaba)
-- @copyright 2012-2018
-- @license [MIT](http://www.opensource.org/licenses/mit-license.php)
-- @release 2.1.0
-- @module ppm.toolkit.fp

local M = {}

--- Returns an array where values are in reverse order. The passed-in array should not be sparse.
-- @name reverse
-- @param array an array
-- @return a reversed array
function M.reverse(array)
  local _array = {}
  for i = #array, 1, -1 do
    _array[#_array + 1] = array[i]
  end
  return _array
end

--- Composes functions. Each passed-in function consumes the return value of the function that follows.
-- In math terms, composing the functions `f`, `g`, and `h` produces the function `f(g(h(...)))`.
-- @name compose
-- @param ... a variable number of functions
-- @return a new function
-- @see pipe
function M.compose(...)
  -- See: https://github.com/Yonaba/Moses/pull/15#issuecomment-139038895
  local f = M.reverse { ... }
  return function(...)
    local first = true
    local _temp = nil
    for i, func in ipairs(f) do
      if first then
        first = false
        _temp = func(...)
      else
        _temp = func(_temp)
      end
    end
    return _temp
  end
end

--- Pipes a value through a series of functions. In math terms,
-- given some functions `f`, `g`, and `h` in that order, it returns `f(g(h(value)))`.
-- @name pipe
-- @param value a value
-- @param ... a variable number of functions
-- @return the result of the composition of function calls.
-- @see compose
function M.pipe(value, ...)
  return M.compose(...)(value)
end

--- Curries a function. If the given function `f` takes multiple arguments, it returns another version of
-- `f` that takes a single argument (the first of the arguments to the original function) and returns a new
-- function that takes the remainder of the arguments and returns the result.
-- @name curry
-- @param f a function
-- @param[opt] n_args the number of arguments expected for `f`. Defaults to 2.
-- @return a curried version of `f`
function M.curry(f, n_args)
  n_args = n_args or 2
  local _args = {}
  local function scurry(v)
    if n_args == 1 then return f(v) end
    if v ~= nil then _args[#_args + 1] = v end
    if #_args < n_args then
      return scurry
    else
      local r = { f(unpack(_args)) }
      _args = {}
      return unpack(r)
    end
  end
  return scurry
end

return M
