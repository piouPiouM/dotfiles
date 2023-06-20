local T = require("ppm.toolkit.fp.table")

local M = {}

function M.identity(...)
  return ...
end

function M.tap(func)
  return function(...)
    func(...)

    return ...
  end
end

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

function M.pipe(value, ...)
  local lambdas = T.reverse({ ... })
  local lambda = M.compose(unpack(lambdas))

  return lambda(value)
end

-- http://lua-users.org/wiki/CurriedLua
function M.curry(func, num_args)
  num_args = num_args or debug.getinfo(func, "u").nparams

  if num_args < 2 then return func end

  local function helper(argtrace, n)
    if n < 1 then
      return func(unpack(T.flatten(argtrace)))
    end

    return function(...)
      return helper({ argtrace, ... }, n - select("#", ...))
    end
  end

  return helper({}, num_args)
end

return M
