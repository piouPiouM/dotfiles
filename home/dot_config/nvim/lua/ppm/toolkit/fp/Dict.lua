---@module 'ppm.toolkit.fp.Dict'

local fp = require("ppm.toolkit.fp.function")
local pipe, reduce = fp.pipe, fp.reduce

---@class Dict<K, A>: { _data: table<K, table>, _len: number }
---@field _len number Size of the contained data.
---@field _data table Actual stored data.
local Dict = {}

local mt = {
  _tag = "dict",
  __index = Dict,
  __len = function(dict)
    return dict._len
  end,
  __tostring = function(ma)
    return ("Dict(%s)"):format(vim.inspect(ma._data))
  end,
}

---@section Constructors

--- Converts a table into a dictionary.
---
---@generic K
---@generic A
---@param t? table<K, A> The table to convert.
---@return Dict<K, A> dict The new dictionary.
Dict.of = function(t)
  local instance = {
    _len = 0,
    _data = {},
  }

  if type(t) == "table" then
    for key, value in pairs(t) do
      if type(value) == "nil" then goto continue end

      instance._len = instance._len + 1
      instance._data[key] = { key, value }
      ::continue::
    end
  end

  return setmetatable(instance, mt)
end

--- Makes an empty dictonary.
---
---@generic K
---@generic A
---@return Dict<K, A>
Dict.zero = function()
  return Dict.of()
end

---@section Refinements

--- Test whether a dictionary is empty.
---
---@generic K
---@generic A
---@param dict Dict<K, A>
---@return boolean
Dict.is_empty = function(dict)
  return #dict == 0
end

--- Checks if the given object is a Dict container.
---
---@param object unknown
---@return boolean
Dict.is_dict = function(object)
  return getmetatable(object) == mt
end

---@section Convertions

---@todo
Dict.to_pairs = function(dict)
  return vim.tbl_extend("force", {}, dict._data)
end

--- Creates a dictionary from a list of tuples `{ key, value }`.
Dict.from_pairs = function(entries)
  return pipe(
    entries,
    reduce({}, function(acc, entry)
      acc[entry[1]] = entry[2]
      return acc
    end),
    Dict.of
  )
end

Dict.from_option = function(ma)
  local O = require("ppm.toolkit.fp.Option")

  return Dict.of(O.is_none(ma) and {} or ma.value)
end

Dict.to_option = function(dict)
  local O = require("ppm.toolkit.fp.Option")

  return Dict.is_empty(dict) and O.none or O.some(dict._data)
end

Dict.from_either = function(either)
  local E = require("ppm.toolkit.fp.Either")

  return Dict.of(E.is_either(either) and E.is_right(either) and either.right or {})
end

---@section Utils

---@section To organize

---
---@generic K
---@generic A
---@alias T Dict<K, A>|table<K, A>
---@param second T
---@return fun(first: T): Dict<K, A>
Dict.concat = function(second)
  return function(first)
    return Dict.of(vim.tbl_deep_extend("force",
      Dict.is_dict(first) and (first --[[@as Dict]])._data or first,
      Dict.is_dict(second) and (second --[[@as Dict]])._data or second
    ))
  end
end

--- Shallowly clones an array table
---
---@generic A
---@generic K
---@param dict Dict<K,A> The dictionary to clone.
---@return Dict<K,A> copy
Dict.copy = function(dict)
  return pipe({}, Dict.concat(dict))
end

--- Maps `f (v, k)` on value-key pairs, collects and returns the results.
--- Uses `pairs` to iterate over elements in `t`.
--- <br/><em>Aliased as `collect`</em>.
---
---@generic K
---@generic A
---@param iteratee fun(value: A, key: K): A an iterator function, prototyped as `f (v, k)`
---@return fun(dict: Dict<K, A>): Dict<K, A>
Dict.map = function(iteratee)
  return function(dict)
    local mapped = {}

    for index, value in pairs(dict._data) do
      local k, kv, v = index, iteratee(value, index)
      mapped[v and kv or k] = v or kv
    end

    return Dict.of(mapped)
  end
end

Dict.reduce = function(initial, iteratee)
  return function(dict)
    ---@cast dict Dict
    return pipe(
      dict._data,
      reduce(initial, iteratee),
      Dict.of
    )
  end
end

--- Provides a safe way to read a value at a particular path from an dictionary.
--- It returns a `None` if the path is not resolved, otherwise a `Some` of the element.
--- TODO unit tests
---
---@generic K
---@generic A
---@param ... K One or more keys via which to index the dictionary.
---@return fun(dict: Dict<K,A>): Option<A>
Dict.lookup = function(...)
  local O = require("ppm.toolkit.fp.Option")
  local path = arg

  return function(dict)
    local value = vim.tbl_get(dict._data, unpack(path))

    return O.fromNullable(value)
  end
end

Dict.delete = function(...)
  local path = arg

  return function(dict)
    return pipe(
    )
  end
end

---@todo
Dict.update = function(fn, ...)
  return function(dict)
  end
end

--- Removes each entry that doesn't satisfy the given predicate function.
---
---@todo
Dict.filter = function(predicate)
  return function(dict)
    local filtered = vim.tbl_filter(function(tuple)
      return predicate(unpack(tuple))
    end, dict._data)

    return Dict.from_pairs(filtered)
  end
end

Dict.pick = Dict.filter

--- Removes each entry that satisfies the given predicate function.
---
---@todo
Dict.omit = function(predicate)
  local function filter(value, key) return not predicate(value, key) end

  return function(dict)
    return pipe(dict, Dict.filter(filter))
  end
end

--- Returns a new object with the provided keys selected.
---
---@todo
Dict.select = function(keys)
  return function(dict)
    return pipe(
      dict,
      Dict.filter(function(_, key) return vim.tbl_contains(dict._data, key) end)
    )
  end
end

return Dict