---@module 'ppm.toolkit.fp.Ord'

local F = require("ppm.toolkit.fp.function")

---@generic A
---@alias CompareFunc fun(first: A, second: A): Ordering
---
---@class Ord<A>: { compare: CompareFunc<A>, equals: EqualsFunc<A> }
local Ord = {}

---@section Constructors

---
---@generic A
---@param compare CompareFunc<A>
---@return Ord<A>
Ord.from_compare = function(compare)
  return {
    compare = function(first, second)
      return first == second and 0 or compare(first, second)
    end,
    equals = function(first, second)
      return first == second or compare(first, second) == 0
    end
  }
end

---@section Combinators

---@generic A
---@generic B
---@param f fun(b: B): A
---@return fun(fa: Ord<A>): Ord<B>
Ord.contramap = function(f)
  ---@generic A
  ---@param fa Ord<A>
  return function(fa)
    return Ord.from_compare(function(first, second)
      return fa.compare(f(first), f(second))
    end)
  end
end

--- Reverse the comparaison order.
---
---@generic A
---@param instance Ord<A>
---@return Ord<A> swapped
Ord.reverse = function(instance)
  return Ord.from_compare(function(first, second)
    return instance.compare(second, first)
  end)
end

Ord.tuple = function(...)
  local ords = { ... }

  return Ord.from_compare(function(first, second)
    local res
    for index, instance in ipairs(ords) do
      res = instance.compare(first[index], second[index])
      if res ~= 0 then
        return res
      end
    end

    return res
  end)
end

---@section Instances

---@generic A
---@return Semigroup<Ord<A>>
Ord.get_semigroup = function()
  return {
    concat = function(first, second)
      return Ord.from_compare(function(a, b)
        local res = first.compare(a, b)
        return res ~= 0 and res or second.compare(a, b)
      end)
    end
  }
end

---@generic A
---@return Monoid<Ord<A>>
Ord.get_monoid = function()
  return {
    concat = Ord.get_semigroup().concat,
    empty = Ord.from_compare(F.constant(0))
  }
end

---@section Utils

--- Test whether a value is between a minimum and a maximum (inclusive).
---
---@generic A
---@param instance Ord<A>
---@return fun(lower: A, upper: A): (fun(value: A): boolean)
Ord.between = function (instance)
  local greaterOrd = Ord.gte(instance)
  local lowerOrd = Ord.lte(instance)

  return function (lower, upper)
    return function (value)
      return lowerOrd(value, upper) and greaterOrd(value, lower)
    end
  end
end

--- Clamp a value between a minimum and a maximum.
---
---@generic A
---@param instance Ord<A>
---@return fun(lower: A, upper: A): (fun(value: A): A)
Ord.clamp = function (instance)
  local maxOrd = Ord.max(instance)
  local minOrd = Ord.min(instance)

  return function (lower, upper)
    return function (value)
      return maxOrd(minOrd(value, upper), lower)
    end
  end
end

--- Test the equality of two values.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.equals = function(instance)
  return function(first, second)
    return first == second or instance.compare(first, second) == 0
  end
end

--- Test whether one value is _strictly greater than_ another.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.gt = function(instance)
  return function(first, second)
    return instance.compare(first, second) == 1
  end
end

--- Test whether one value is _strictly less than_ another.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.lt = function(instance)
  return function(first, second)
    return instance.compare(first, second) == -1
  end
end

--- Test whether one value is _non-strictly greater than_ another.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.gte = function(instance)
  return function(first, second)
    return instance.compare(first, second) ~= -1
  end
end

--- Test whether one value is _non-strictly less than_ another.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.lte = function(instance)
  return function(first, second)
    return instance.compare(first, second) ~= 1
  end
end

--- Take the minimum of two values.
--- If they are equal, the first argument is chosen.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.min = function(instance)
  return function(first, second)
    return (first == second or instance.compare(first, second) < 1) and first or second
  end
end

--- Take the maximum of two values.
--- If they are equal, the first argument is chosen.
---
---@generic A
---@param instance Ord<A>
---@return fun(first: A, second: A): boolean
Ord.max = function(instance)
  return function(first, second)
    return (first == second or instance.compare(first, second) > -1) and first or second
  end
end

return Ord