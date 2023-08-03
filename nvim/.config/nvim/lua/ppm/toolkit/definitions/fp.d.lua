---@meta

---@alias Ordering -1 | 0 | 1

--- Represents types that have an upper and lower boundary.
--- Extends `Ord<A>`.
---@class Bounded<A>: { compare: CompareFunc<A>, equals: EqualsFunc<A>, top: A, bottom: A }

--- Extends `Semigroup<A>`.
---@class Monoid<A>: { concat: fun(x: A, y: A): A, empty: A }

--- An array.
---@class Array<A>: { [integer]: A }

--- An array with at least one entry.
---@class NonEmptyArray<A>: { [1]: A, [integer?]: A }

--- A function invoked per iteration over elements of a table.
---@generic K: number
---@alias Iteratee<V,R,K> fun(value: V, index?: K, collection?: table<K,V>): R