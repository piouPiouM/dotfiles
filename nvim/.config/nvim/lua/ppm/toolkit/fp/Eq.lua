---@module 'ppm.toolkit.fp.Eq'

local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

---@generic A
---@alias EqualsFunc fun(first: A, second: A): boolean
---
---@class Eq<A>: { equals: EqualsFunc<A> }
local Eq = {}

---@section Constructors

---@generic A
---@param operation EqualsFunc<A>
---@return Eq<A>
Eq.from_equals = function(operation)
  return {
    ---@generic A
    ---@param first A
    ---@param second A
    ---@return boolean
    equals = function(first, second)
      return first == second or operation(first, second)
    end
  }
end

---@section Pipeables

---@generic A
---@generic B
---@param f fun(b: B): A
---@return fun(fa: Eq<A>): Eq<B>
Eq.contramap = function(f)
  ---@generic A
  ---@param fa Eq<A>
  return function(fa)
    return Eq.from_equals(function(first, second)
      return fa.equals(f(first), f(second))
    end)
  end
end

---@section Combinators

---@generic K
---@param eqs_by_property table<K, Eq<unknown>>
---@return Eq<table<K, unknown>>
Eq.struct = function(eqs_by_property)
  return Eq.from_equals(function(first, second)
    for key, instance in pairs(eqs_by_property) do
      if not instance.equals(first[key], second[key]) then
        return false
      end
    end

    return true
  end)
end

--- Given a tuple of `Eq`s returns a `Eq` for the tuple.
---
---@generic A
---@param ... Eq<A>
Eq.tuple = function(...)
  local A = require("ppm.toolkit.fp.Array")
  local eqs = { ... }

  return Eq.from_equals(function(first, second)
    return pipe(
      eqs,
      A.every(function(instance, i) return instance.equals(first[i], second[i]) end)
    )
  end)
end

---@section Instances

---@generic A
---@return Semigroup<Eq<A>>
Eq.get_semigroup = function()
  return {
    concat = function(first, second)
      return Eq.from_equals(function(a, b)
        return first.equals(a, b) and second.equals(a, b)
      end)
    end
  }
end

---@generic A
---@return Monoid<Eq<A>>
Eq.get_monoid = function()
  return {
    concat = Eq.get_semigroup().concat,
    empty = F.constTrue
  }
end

return Eq