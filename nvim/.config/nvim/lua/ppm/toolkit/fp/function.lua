local M = {}

M.debug = function(message)
  return function(x)
    print(message)
    P(x)
  end
end

--- A lazy argument.
---@alias LazyArg<A> fun(): A

M.apply = function(f)
  return function(x)
    return f(x)
  end
end

--- Creates a function that returns the result of invoking the given functions from right to left,
--- where each successive invocation is supplied the return value of the previous.
---
---@generic T
---@generic R
---@param ... fun(v: T): R
---@return fun(...: T): R
M.compose = function(...)
  local lambdas = { ... }
  local count = #lambdas

  return function(...)
    local state = table.pack(...)
    local index = count

    while index > 0 do
      state = { lambdas[index](unpack(state)) }
      index = index - 1
    end

    return unpack(state)
  end
end

--- Returns a function that always returns the same value.
---
---@generic A
---@param value A
---@return LazyArg<A> value
M.constant = function(value)
  return function(_)
    return value
  end
end

--- A thunk that returns always `nil`.
---
---@return LazyArg<nil>
M.constNil = function()
  return M.constant(nil)
end

--- A thunk that returns always `false`.
---
---@return LazyArg<boolean>
M.constFalse = function()
  return M.constant(false)
end

--- A thunk that returns always `true`.
---
---@return LazyArg<boolean>
M.constTrue = function()
  return M.constant(true)
end

M.copy = function(t)
  return vim.tbl_extend("force", {}, t)
end

--- https://gist.github.com/jcmoyer/5571987
M.curry = function(f)
  local info = debug.getinfo(f, "u")

  local function docurry(s, left, ...)
    local ptbl = M.copy(s)
    local vargs = { ... }
    for i = 1, #vargs do
      ptbl[#ptbl + 1] = vargs[i]
    end
    left = left - #vargs
    if left > 0 then
      return function(...)
        return docurry(ptbl, left, ...)
      end
    else
      return f(unpack(ptbl))
    end
  end

  return function(...)
    return docurry({}, info.nparams, ...)
  end
end

--- Returns the first argument it receives.
---
---@generic T
---@param value T
---@param ... any Extra arguments are ignored.
---@return T
M.identity = function(value, ...)
  return value
end

--- Applies the `iteratee` function to each element of the `collection`.
---
--- The iteratee is invoked with three arguments: `(value, index|key, collection)`.
--- Returns a new table.
---
---@generic A Input values
---@generic B Ouput values
---@generic K Keys
---@param iteratee? Iteratee<A,B> The function invoked per iteration.
---@return fun(collection: table<K,A>): table<K,B> # The new mapped table.
M.map = function(iteratee)
  local callback = iteratee or M.identity

  return function(collection)
    local result = {}

    for key, value in pairs(collection) do
      result[key] = callback(value, key, collection)
    end

    return result
  end
end

--TODO
M.reduce = function(initial, iteratee)
  return function(t)
    local acc = initial
    for key, value in pairs(t) do
      acc = iteratee(acc, value, key, t)
    end

    return acc
  end
end

--- Pipes the value of an expression into a pipeline of functions.
---
---@generic T
---@generic R
---@param value T
---@param ... fun(a: T|R): R
---@return R
M.pipe = function(value, ...)
  local lambdas = M.reverse({ ... })
  local lambda = M.compose(unpack(lambdas))

  return lambda(value)
end

--- Reverse an array, creating a new array
--- The passed-in array should not be sparse.
---
---@generic A
---@param array table<A> The table to reverse.
---@return table<A> reversed A new array where values are in reverse order.
M.reverse = function(array)
  local _array = {}

  for i = #array, 1, -1 do
    _array[#_array + 1] = array[i]
  end

  return _array
end

--- Runs the given function with the supplied value, then returns the value.
---
---@generic A
---@param f fun(value: A)
---@return fun(value: A): A
M.tap = function(f)
  return function(value)
    f(value)

    return value
  end
end

M.foldm = function(monoid)
  assert(
    type(monoid["concat"]) == "function" and monoid["empty"] ~= nil,
    "Given `monoid` is not a Monoid.")

  return function(...)
    return M.reduce(monoid.empty, monoid.concat)({ ... })
  end
end

---@section Aliases

M.always = M.constant

return M
