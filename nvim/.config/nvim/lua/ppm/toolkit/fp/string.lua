local M = {}

---@section Instances

---@type Eq<string>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Semigroup<string>
M.semigroup_sum = {
  ---@param first string
  ---@param second string
  ---@return string
  concat = function(first, second)
    return first .. second
  end
}

---@type Monoid<string>
M.monoid_sum = {
  concat = M.semigroup_sum.concat,
  empty = ""
}

---@section Utilities

M.replace = function(pattern, replacement)
  return function(s)
    local result = string.gsub(s, pattern, replacement)

    return result
  end
end

M.to_upper = string.upper

M.to_lower = string.lower

M.trim = vim.trim

M.trim_left = M.replace("^%s+", "")

M.trim_right = M.replace("%s+$", "")

M.split = function(separator)
  return function(s)
    return vim.fn.split(s, separator, false)
  end
end

M.words = M.split("\\s\\+")

M.starts_with = function(pattern, position)
  return function(s)
    return string.find(s, pattern) == (position or 1)
  end
end

M.ends_with = function(pattern, position)
  return function(s)
    local _, stop = string.find(s, pattern)

    return stop == (type(position) == "number" and position or #s)
  end
end

M.includes = function(pattern, position)
  return function(s)
    local start = string.find(s, pattern)

    return position >= 1 and start == position or start >= 1
  end
end

return M
