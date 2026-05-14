---@module 'ppm.toolkit.fp.Semigroup'

local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

---@generic A
---@alias ConcatOperation fun(first: A, second: A): A

---@class Magma<A>: { concat: ConcatOperation<A> }

--- Implements `Magma<A>`.
---@generic A
---@class Semigroup<A>: { concat: ConcatOperation<A> }
local Semigroup = {}

--- Helper to create new semigroup.
---
---@generic A
---@param operation ConcatOperation<A>
---@return Semigroup<A>
local from_concat = function(operation)
  return {
    concat = operation
  }
end

---@section Constructors

--- Get a semigroup where `concat` will return the minimum, based on the provided order.
---
---@generic A
---@param instance Ord<A>
---@return Semigroup<A>
Semigroup.min = function(instance)
  local Ord = require("ppm.toolkit.fp.Ord")
  return {
    concat = Ord.min(instance)
  }
  -- from_concat(Ord.min(ord))
end

--- Get a semigroup where `concat` will return the maximum, based on the provided order.
---
---@generic A
---@param ord Ord<A>
---@return Semigroup<A>
Semigroup.max = function(ord)
  local Ord = require("ppm.toolkit.fp.Ord")
  return from_concat(Ord.max(ord))
end

---@section Combinators

---@generic A
---@param middle A
---@return fun(instance: Semigroup<A>): Semigroup<A>
Semigroup.intercalate = function(middle)
  return function(instance)
    return from_concat(function(first, second)
      return instance.concat(first, instance.concat(middle, second))
    end)
  end
end

--- Returns a new semigroup with concat's arguments swapped.
---
---@generic A
---@param instance Semigroup<A>
---@return Semigroup<A>
Semigroup.reverse = function(instance)
  return from_concat(function(first, second)
    return instance.concat(second, first)
  end)
end

---@generic A
---@generic K
---@param semigroups_by_property table<K, Semigroup<A>>
---@return Semigroup<table<K, A>>
Semigroup.struct = function(semigroups_by_property)
  return from_concat(function(first, second)
    local res = {}
    for property, instance in pairs(semigroups_by_property) do
      res[property] = instance.concat(first[property], second[property])
    end

    return res
  end)
end

---@generic A
---@param ... Semigroup<A>
Semigroup.tuple = function(...)
  local A = require("ppm.toolkit.fp.Array")
  local semigroups = { ... }

  return from_concat(function(first, second)
    return pipe(
      semigroups,
      A.map(function(instance, i) return instance.concat(first[i], second[i]) end)
    )
  end)
end

---@section Utils

---@generic A
---@param instance Semigroup<A>
---@return fun(initial: A): (fun(array: A[]): A)
Semigroup.concat_all = function(instance)
  return function(initial)
    return function(array)
      return F.reduce(initial, instance.concat)(array)
    end
  end
end

return Semigroup
