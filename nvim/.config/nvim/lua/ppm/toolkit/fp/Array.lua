--- Provides tools for working with Lua’s array type in a functional way.
---@module 'ppm.toolkit.fp.Array'

local F = require("ppm.toolkit.fp.function")
local unpack = unpack or table.unpack
local map, pipe = F.map, F.pipe

---@class Array
local Array = {}

local function _assertType(array)
  assert(vim.isarray(array), "not an array -> " .. tostring(array))
end

---@section Constructors

--- Given an element of the base type, `of` builds an array containing just that element of the base type.
---
---@generic A
---@param value A
---@return Array<A>
Array.of = function(value)
  return { value }
end

---
---@generic A
---@param maker fun(index: number): A
---@return fun(n: number): NonEmptyArray<A>
Array.make_by = function(maker)
  return function(n)
    local result = { maker(1) }

    for i = 2, math.floor(n) do
      table.insert(result, maker(i))
    end

    return result
  end
end

---@section Instances

---
---@generic A
---@param eq Eq<A>
---@return Eq<A[]>
Array.get_eq = function(eq)
  -- Must be loaded on demand to avoid circular dependency error.
  local Eq = require("ppm.toolkit.fp.Eq")

  ---@param first unknown[]
  ---@param second unknown[]
  return Eq.from_equals(function(first, second)
    return #first == #second
        and pipe(first, Array.every(function(x, i) return eq.equals(x, second[i]) end))
  end)
end

---@generic A
---@return Semigroup<A[]>
Array.get_semigroup = function()
  return {
    concat = function(first, second)
      return pipe(first, Array.concat(second))
    end
  }
end

---@generic A
---@return Monoid<A[]>
Array.get_monoid = function()
  return {
    concat = Array.get_semigroup().concat,
    empty = {},
  }
end

--- To implement.
---@package
Array.get_ord = function()
  ---TODO
end

---@section Refinements

--- Test whether an array is empty.
---
---@generic A
---@param array Array<A>
---@return boolean
Array.is_empty = function(array)
  _assertType(array)
  return vim.tbl_isempty(array)
end

--- Test whether an array is not empty.
---
---@generic A
---@param array Array<A>
---@return boolean
Array.is_non_empty = function(array)
  return not Array.is_empty(array)
end

---@section Conversions

--- Create an array from an `Option`.
--- The resulting array will contain the content of the `Option` if it is `Some`
--- and it will be empty if the `Option` is `None`.
---
---@generic A
---@param ma Option<A> The Option used to create the new array.
---@return Array<A> array
Array.from_option = function(ma)
  local O = require("ppm.toolkit.fp.Option")

  return O.is_none(ma) and {} or { ma.value }
end

---@section Combinators

--- Sort the given array by using an Ord.
---
---@generic A
---@generic B
---@param ord Ord<B>
---@return fun(array: A[]): A[]
Array.sort = function(ord)
  return function(array)
    return #array == 1
        and array
        or vim.fn.sort(array, ord.compare)
  end
end

---@section Filtering

--- Removes each entry that doesn't satisfy the given predicate function.
---
---@generic A
---@param predicate PredicateArray<A>
---@return fun(array: A[]): A[]
Array.filter = function(predicate)
  return function(array)
    local result = {}

    for index, value in ipairs(array) do
      if predicate(value, index, array) then
        table.insert(result, value)
      end
    end

    return result
  end
end

--- FIXME: add a description.
---
---@generic A
---@generic B
---@param f fun(value: A, index: integer): Option<B>
---@return fun(array: A[]): B[]
Array.filter_map = function(f)
  local O = require("ppm.toolkit.fp.Option")

  return function(array)
    local result = {}

    for index, value in ipairs(array) do
      local option_b = f(value, index)
      if O.is_some(option_b) then
        table.insert(result, option_b.value)
      end
    end

    return result
  end
end

--- Removes the `None` from an array of optionals.
---
---@generic A
---@generic B
---@diagnostic disable-next-line: undefined-doc-name
---@overload fun(array: Option<A>[]): Option<B>[]
Array.compact = Array.filter_map(F.identity)

---@section Utils

--- Inserts `value` to the end of `array`.
---
---@generic A
---@param value A
---@return fun(array: A[]): A
function Array.append(value)
  return function(array)
    local t = Array.copy(array)
    table.insert(t, value)

    return t
  end
end

--- Inserts `value` to the begining of `array`.
---
---@generic A
---@param value A
---@return fun(array: A[]): A
function Array.prepend(value)
  return function(array)
    local t = Array.copy(array)
    table.insert(t, 1, value)

    return t
  end
end

--- Concatenate two arrays into a new array.
---
---@generic A
---@generic B
---@param second B[]
---@return fun(first: Array<A> | Array<B>): Array<A | B>
Array.concat = function(second)
  return function(first)
    if Array.is_empty(first) then return F.copy(second) end
    if Array.is_empty(second) then return F.copy(first) end

    local result = F.copy(first)

    for _, value in pairs(second) do
      table.insert(result, value)
    end

    return result
  end
end

--- Shallowly clones an array table
---
---@generic A
---@param array A[] The dictionary to clone.
---@return A[] copy
Array.copy = function(array)
  return F.copy(array)
end

--- Test whether an array contains a particular index.
---
---@generic A
---@param index number The index to look for.
---@param array Array<A> The array in which to look.
---@return boolean
Array.is_out_of_bound = function(index, array)
  _assertType(array)

  return index < 1 or index > #array
end

--- Gets the first element of `array`.
---
---@generic A
---@param array Array<A> The array to query.
---@return Option<A> first The first element of `array` if exists.
Array.head = function(array)
  _assertType(array)
  local O = require("ppm.toolkit.fp.Option")

  return Array.is_empty(array) and O.none or O.some(array[1])
end

Array.map = map

--- Get the last element in an array, or a `None` if the array is empty.
---
---@generic A
---@param array Array<A> The array to query.
---@return Option<A> last The last element of `array` if exists.
Array.last = function(array)
  _assertType(array)
  local O = require("ppm.toolkit.fp.Option")

  return Array.is_empty(array) and O.none or O.some(array[#array])
end

--- Provides a safe way to read a value at a particular index from an array.
--- It returns a `None` if the index is out of bounds, and a `Some` of the element
--- if the index is valid.
---
---@generic A
---@param index number
---@return fun(array: Array<A>): Option<A> value
Array.lookup = function(index)
  local O = require("ppm.toolkit.fp.Option")

  return function(array)
    return Array.is_out_of_bound(index, array) and O.none or O.is_some(array[index])
  end
end

Array.reverse = F.reverse

--- Calculate the number of elements in an array.
---
---@generic A
---@param array Array<A>
---@return number length
Array.size = function(array)
  _assertType(array)

  return #array
end

--- Keep only a max number of elements from the start of an array, creating a new array.
---
---@generic A
---@param num number
---@return fun(array: Array<A>): Array<A>
Array.take_left = function(num)
  return function(array)
    return num == 0 and {} or Array.is_out_of_bound(num, array)
        and F.copy(array)
        or { unpack(array, 1, num) }
  end
end

--- Keep only a max number of elements from the end of an array, creating a new array.
---
---@generic A
---@param num number
---@return fun(array: Array<A>): Array<A>
Array.take_right = function(num)
  return function(array)
    return num == 0 and {} or Array.is_out_of_bound(num, array)
        and F.copy(array)
        or { unpack(array, #array - (num - 1)) }
  end
end

---@generic A
---@generic B
---@param fa Array<A>
---@return fun(fab: Array<fun(a: A): B>): Array<B>
Array.ap = function(fa)
  return Array.flatmap(function(f)
    return pipe(fa, map(f))
  end)
end

--- Squashes first level of nested arrays.
---
---@generic A
---@param array Array<A>
---@return Array<A>
Array.join = function(array)
  local result = {}

  for _, value in ipairs(array) do
    if type(value) == "table" then
      result = Array.concat(value)(result)
    else
      table.insert(result, value)
    end
  end

  return result
end

---
---@generic A
---@generic B
---@param iteratee Iteratee<A, B>
---@return fun(array: Array<A>): Array<B>
Array.flatmap = function(iteratee)
  return function(array)
    return pipe(
      array,
      map(iteratee),
      Array.join
    )
  end
end

Array.flatten = Array.flatmap(F.identity)

--- Checks if `predicate` returns truthy for all elements of array.
---
---@generic A
---@param predicate Iteratee<A, boolean, number>
---@return fun(array: Array<A>): boolean
Array.every = function(predicate)
  return function(array)
    if Array.is_empty(array) then return true end

    local result, success = false, false

    for index, value in ipairs(array) do
      success, result = pcall(predicate, value, index, array)
      if not success or not result then
        break
      end
    end

    return result
  end
end

return Array