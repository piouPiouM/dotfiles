local M = {}

---@section Instances

---@type Eq<boolean>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Semigroup<boolean>
M.semigroup_all = {
  ---@param first boolean
  ---@param second boolean
  ---@return boolean
  concat = function(first, second)
    return first and second
  end
}

---@type Semigroup<boolean>
M.semigroup_any = {
  ---@param first boolean
  ---@param second boolean
  ---@return boolean
  concat = function(first, second)
    return first or second
  end
}

---@type Monoid<boolean>
M.monoid_all = {
  concat = M.semigroup_all.concat,
  empty = true
}

---@type Monoid<boolean>
M.monoid_any = {
  concat = M.semigroup_any.concat,
  empty = false
}

return M
