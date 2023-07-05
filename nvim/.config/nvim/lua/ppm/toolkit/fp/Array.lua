--- Provides tools for working with Lua’s array type in a functional way.
---@module 'ppm.toolkit.fp.Array'

local F = require("ppm.toolkit.fp.function")
local unpack = unpack or table.unpack
local map, pipe = F.map, F.pipe

---@class Array
local M = {}

local function _assertType(array)
  assert(vim.tbl_isarray(array), " not an array")
end

---@section Constructors

--- Given an element of the base type, `of` builds an array containing just that element of the base type.
---
---@generic A
---@param value A
---@return Array<A>
M.of = function(value)
  return { value }
end

--- Makes an empty array.
---
---@generic A
---@return Array<A>
M.zero = function()
  return {}
end

---
---@generic A
---@param maker fun(index: number): A
---@return fun(n: number): NonEmptyArray<A>
M.makeBy = function(maker)
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
M.getEq = function(eq)
  -- Must be loaded on demand to avoid circular dependency error.
  local Eq = require("ppm.toolkit.fp.Eq")

  ---@param first unknown[]
  ---@param second unknown[]
  return Eq.fromEquals(function(first, second)
    return #first == #second
        and pipe(first, M.every(function(x, i) return eq.equals(x, second[i]) end))
  end)
end

---@section Refinements

--- Test whether an array is empty.
---
---@generic A
---@param array Array<A>
---@return boolean
M.is_empty = function(array)
  _assertType(array)
  return vim.tbl_isempty(array)
end

--- Test whether an array is not empty.
---
---@generic A
---@param array Array<A>
---@return boolean
M.is_non_empty = function(array)
  return not M.is_empty(array)
end

---@section Conversions

--- Create an array from an `Option`.
--- The resulting array will contain the content of the `Option` if it is `Some`
--- and it will be empty if the `Option` is `None`.
---
---@generic A
---@param ma Option<A> The Option used to create the new array.
---@return Array<A> array
M.fromOption = function(ma)
  local O = require("ppm.toolkit.fp.Option")

  return O.is_none(ma) and {} or { ma.value }
end

---@section Combinators

---@section Utils

--- Clones array and appends values from another array.
---@deprecated
---@see Array.concat
function M.append(array, other)
  local t = {}
  for i, v in ipairs(array) do t[i] = v end
  for _, v in ipairs(other) do t[#t + 1] = v end

  return t
end

--- Concatenate two arrays into a new array.
---
---@generic A
---@generic B
---@param second B[]
---@return fun(first: Array<A> | Array<B>): Array<A | B>
M.concat = function(second)
  return function(first)
    if M.is_empty(first) then return F.copy(second) end
    if M.is_empty(second) then return F.copy(first) end

    local result = F.copy(first)

    for _, value in pairs(second) do
      table.insert(result, value)
    end

    return result
  end
end

--- Test whether an array contains a particular index.
---
---@generic A
---@param index number The index to look for.
---@param array Array<A> The array in which to look.
---@return boolean
M.is_out_of_bound = function(index, array)
  _assertType(array)

  return index < 1 or index > #array
end

--- Gets the first element of `array`.
---
---@generic A
---@param array Array<A> The array to query.
---@return Option<A> first The first element of `array` if exists.
M.head = function(array)
  _assertType(array)
  local O = require("ppm.toolkit.fp.Option")

  return M.is_empty(array) and O.none or O.some(array[1])
end

--- Get the last element in an array, or a `None` if the array is empty.
---
---@generic A
---@param array Array<A> The array to query.
---@return Option<A> last The last element of `array` if exists.
M.last = function(array)
  _assertType(array)
  local O = require("ppm.toolkit.fp.Option")

  return M.is_empty(array) and O.none or O.some(array[#array])
end

--- Provides a safe way to read a value at a particular index from an array.
--- It returns a `None` if the index is out of bounds, and a `Some` of the element
--- if the index is valid.
---
---@generic A
---@param index number
---@return fun(array: Array<A>): Option<A> value
M.lookup = function(index)
  local O = require("ppm.toolkit.fp.Option")

  return function(array)
    return M.is_out_of_bound(index, array) and O.none or O.is_some(array[index])
  end
end

M.reverse = F.reverse

--- Calculate the number of elements in an array.
---
---@generic A
---@param array Array<A>
---@return number length
M.size = function(array)
  _assertType(array)

  return #array
end

--- Keep only a max number of elements from the start of an array, creating a new array.
---
---@generic A
---@param num number
---@return fun(array: Array<A>): Array<A>
M.takeLeft = function(num)
  return function(array)
    return num == 0 and {} or M.is_out_of_bound(num, array)
        and F.copy(array)
        or { unpack(array, 1, num) }
  end
end

--- Keep only a max number of elements from the end of an array, creating a new array.
---
---@generic A
---@param num number
---@return fun(array: Array<A>): Array<A>
M.takeRight = function(num)
  return function(array)
    return num == 0 and {} or M.is_out_of_bound(num, array)
        and F.copy(array)
        or { unpack(array, #array - (num - 1)) }
  end
end

---@generic A
---@generic B
---@param fa Array<A>
---@return fun(fab: Array<fun(a: A): B>): Array<B>
M.ap = function(fa)
  return M.flatMap(function(f)
    return pipe(fa, map(f))
  end)
end

--- Squashes first level of nested arrays.
---
---@generic A
---@param array Array<A>
---@return Array<A>
M.join = function(array)
  local result = {}

  for _, value in ipairs(array) do
    if type(value) == "table" then
      result = M.concat(value)(result)
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
M.flatMap = function(iteratee)
  return function(array)
    return pipe(
      array,
      map(iteratee),
      M.join
    )
  end
end

M.flatten = M.flatMap(F.identity)

--- Checks if `predicate` returns truthy for all elements of array.
---
---@generic A
---@param predicate Iteratee<A, boolean, number>
---@return fun(array: Array<A>): boolean
M.every = function(predicate)
  return function(array)
    if M.is_empty(array) then return true end

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

return M