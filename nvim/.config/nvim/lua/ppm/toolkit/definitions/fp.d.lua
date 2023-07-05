---@meta

---@class Magma<A>: { concat: fun(x: A, y: A): A }

--- Implements `Magma<A>`.
---@class Semigroup<A>: { concat: fun(x: A, y: A): A }

--- Extends `Semigroup<A>`.
---@class Monoid<A>: { concat: fun(x: A, y: A): A, empty: A }

--- An array.
---@class Array<A>: { [integer]: A }

--- An array with at least one entry.
---@class NonEmptyArray<A>: { [1]: A, [integer?]: A }

--- A function invoked per iteration over elements of a table.
---@generic K: number
---@alias Iteratee<V,R,K> fun(value: V, index?: K, collection?: table<K,V>): R
