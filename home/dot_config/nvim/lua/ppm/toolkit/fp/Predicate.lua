---@module 'ppm.toolkit.fp.Predicate'

local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

---@alias Predicate<A> fun(a: A): boolean
---@alias PredicateArray<A> fun(value: A, index: integer?, array: A[]?): boolean

local M = {}

---@section Combinators

---@generic A
---@generic B
---@param f fun(b: B): A
---@return fun(predicate: Predicate<A>): Predicate<B>
M.contramap = function(f)
  return function(predicate)
    return F.flow(f, predicate)
  end
end

---@section Instances

---@generic A
---@return Semigroup<Predicate<A>>
M.get_semigroup_all = function()
  return {
    concat = function(first, second)
      return pipe(first, M.K(second))
    end
  }
end

---@generic A
---@return Monoid<Predicate<A>>
M.get_monoid_all = function()
  return {
    concat = M.get_semigroup_all().concat,
    empty = M.constTrue
  }
end

---@generic A
---@return Semigroup<Predicate<A>>
M.get_semigroup_any = function()
  return {
    concat = function(first, second)
      return pipe(first, M.A(second))
    end
  }
end

---@generic A
---@return Monoid<Predicate<A>>
M.get_monoid_any = function()
  return {
    concat = M.get_semigroup_any().concat,
    empty = M.constFalse
  }
end

---@section Utils

--- Performs a disjunction. Same as `or`, a Lua reserved keyword.
---
--- Polish notation of the disjunction: **A**lternatywa.
---
---@generic A
---@param second Predicate<A>
---@return fun(first: Predicate<A>): (fun(value): Predicate<A>)
M.A = function(second)
  return function(first)
    return function(value)
      return first(value) or second(value)
    end
  end
end

--- Performs a conjunction. Same as `and`, a Lua reserved keyword.
---
--- Polish notation of the conjunction: **K**oniunkcja.
---
---@generic A
---@param second Predicate<A>
---@return fun(first: Predicate<A>): (fun(value): Predicate<A>)
M.K = function(second)
  return function(first)
    return function(value)
      return first(value) and second(value)
    end
  end
end

--- Performs a negation. Same as `not`, a Lua reserved keyword.
---
--- Polish notation of the conjunction: **N**egacja.
---
---@generic A
---@param predicate Predicate<A>
---@return fun(value): Predicate<A>
M.N = function(predicate)
  return function(value)
    return not predicate(value)
  end
end

return M
