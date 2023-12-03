--- Monoids let us write easily-optimised and expressive reduce operations.
---
---@module 'ppm.toolkit.fp.Monoid'

local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

--- Extends `Semigroup<A>` by providing an additional `empty` value.
---@class Monoid<A>: { concat: (fun(x: A, y: A): A), empty: A }
local Monoid = {}

---@section Constructors

--- Get a monoid where `concat` will return the minimum, based on the provided bounded order.
---
---@generic A
---@param bounded Bounded<A>
---@return Monoid<A>
Monoid.min = function(bounded)
  local S = require("ppm.toolkit.fp.Semigroup")

  return {
    concat = S.min(bounded).concat,
    empty = bounded.top
  }
end

--- Get a monoid where `concat` will return the maximum, based on the provided bounded order.
---
---@generic A
---@param bounded Bounded<A>
---@return Monoid<A>
Monoid.max = function(bounded)
  local S = require("ppm.toolkit.fp.Semigroup")

  return {
    concat = S.max(bounded).concat,
    empty = bounded.bottom
  }
end

---@section Combinators

---@generic A
---@param middle A
---@return fun(instance: Monoid<A>): Monoid<A>
Monoid.intercalate = function(middle)
  return function(instance)
    return {
      concat = function(first, second)
        return first == instance.empty
            and instance.concat(first, second)
            or instance.concat(first, instance.concat(middle, second))
      end,
      empty = instance.empty
    }
  end
end

--- Returns a new monoid with concat's arguments swapped.
---
---@generic A
---@param instance Monoid<A>
---@return Monoid<A>
Monoid.reverse = function(instance)
  local S = require("ppm.toolkit.fp.Semigroup")

  return {
    concat = S.reverse(instance).concat,
    empty = instance.empty
  }
end

---@generic A
---@generic K
---@param monoids_by_property table<K, Monoid<A>>
---@return Monoid<table<K, A>>
Monoid.struct = function(monoids_by_property)
  local S = require("ppm.toolkit.fp.Semigroup")
  local empty = {}

  for property, instance in pairs(monoids_by_property) do
    empty[property] = instance.empty
  end

  return {
    concat = S.struct(monoids_by_property).concat,
    empty = empty
  }
end

---@generic A
---@param ... Monoid<A>
---@return Monoid<A>
Monoid.tuple = function(...)
  local A = require("ppm.toolkit.fp.Array")
  local S = require("ppm.toolkit.fp.Semigroup")
  local monoids = { ... }

  return {
    concat = S.tuple(...).concat,
    empty = pipe(
      monoids,
      A.map(function(instance) return instance.empty end)
    )
  }
end

---@section Utils

---@generic A
---@param monoid Monoid<A>
---@return fun(array: A[]): A
Monoid.concat_all = function(monoid)
  local SC = require("ppm.toolkit.fp.Semigroup")

  return SC.concat_all(monoid)(monoid.empty)
end

return Monoid