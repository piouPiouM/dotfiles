local M = {}

--- Shallowly clones an array table
---
---@param t table The table to clone.
---@return table t_cloned
function M.clone(t)
  local r = {}

  for i = 1, #t do
    r[#r + 1] = t[i]
  end

  return r
end

function M.flatten(t)
  local ret = {}

  for _, v in ipairs(t) do
    if type(v) == 'table' then
      for _, fv in ipairs(M.flatten(v)) do
        ret[#ret + 1] = fv
      end
    else
      ret[#ret + 1] = v
    end
  end

  return ret
end

--- Returns an array where values are in reverse order. The passed-in array should not be sparse.
-- @name reverse
-- @param array an array
-- @return a reversed array
function M.reverse(array)
  local _array = {}
  for i = #array, 1, -1 do
    _array[#_array + 1] = array[i]
  end
  return _array
end

function M.head(t)
  return t[1]
end

function M.concat(separator, i, j)
  return function(t)
    return table.concat(t, separator, i, j)
  end
end

--- Maps `f (v, k)` on value-key pairs, collects and returns the results.
-- Uses `pairs` to iterate over elements in `t`.
-- <br/><em>Aliased as `collect`</em>.
-- @name map
-- @param t a table
-- @param f  an iterator function, prototyped as `f (v, k)`
-- @return a table of results
-- @see mapi
function M.map(t, f)
  local _t = {}
  for index, value in pairs(t) do
    local k, kv, v = index, f(value, index)
    _t[v and kv or k] = v or kv
  end
  return _t
end

--- Clones array and appends values from another array.
-- @name append
-- @param array an array
-- @param other an array
-- @return a new array
function M.append(array, other)
  local t = {}
  for i, v in ipairs(array) do t[i] = v end
  for _, v in ipairs(other) do t[#t + 1] = v end

  return t
end

return M
