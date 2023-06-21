local T = require("ppm.toolkit.fp.table")

local M = {}

function M.apply(f)
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
function M.compose(...)
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

---
---@generic A
---@param value A
---@return A value
function M.constant(value)
  return function(_)
    return value
  end
end

--- https://gist.github.com/jcmoyer/5571987
function M.curry(f)
  local info = debug.getinfo(f, 'u')

  local function docurry(s, left, ...)
    local ptbl = T.clone(s)
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
---@diagnostic disable-next-line: unused-vararg
function M.identity(value, ...)
  return value
end

--- Pipes the value of an expression into a pipeline of functions.
---
---@generic T
---@generic R
---@param value T
---@param ... fun(a: T|R): R
---@return R
function M.pipe(value, ...)
  local lambdas = T.reverse({ ... })
  local lambda = M.compose(unpack(lambdas))

  return lambda(value)
end

--- Runs the given function with the supplied value, then returns the value.
---
---@generic A
---@param f fun(value: A)
---@return fun(value: A): A
function M.tap(f)
  return function(value)
    f(value)

    return value
  end
end

return M
