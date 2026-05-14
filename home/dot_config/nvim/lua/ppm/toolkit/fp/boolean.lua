local M = {}

---@section Instances

---@type Eq<boolean>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Ord<boolean>
M.Ord = {
  equals = M.Eq.equals,
  compare = function(first, second)
    return first == second and 0 or first == false and -1 or 1
  end
}

---@type Semigroup<boolean>
M.Semigroup_all = {
  ---@param first boolean
  ---@param second boolean
  ---@return boolean
  concat = function(first, second)
    return first and second
  end
}

---@type Semigroup<boolean>
M.Semigroup_any = {
  ---@param first boolean
  ---@param second boolean
  ---@return boolean
  concat = function(first, second)
    return first or second
  end
}

---@type Monoid<boolean>
M.Monoid_all = {
  concat = M.Semigroup_all.concat,
  empty = true
}

---@type Monoid<boolean>
M.Monoid_any = {
  concat = M.Semigroup_any.concat,
  empty = false
}

return M
