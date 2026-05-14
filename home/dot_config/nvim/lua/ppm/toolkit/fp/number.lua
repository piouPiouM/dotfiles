local M = {}

---@section Instances

---@type Eq<number>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Ord<number>
M.Ord = {
  equals = M.Eq.equals,
  compare = function(first, second)
    return first < second and -1 or first > second and 1 or 0
  end
}

---@type Semigroup<number>
M.Semigroup_max = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return math.max(first, second)
  end
}

---@type Semigroup<number>
M.Semigroup_min = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return math.min(first, second)
  end
}

---@type Magma<number>
M.Magma_sub = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first - second
  end
}

---@type Semigroup<number>
M.Semigroup_sum = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first + second
  end
}

---@type Semigroup<number>
M.Semigroup_product = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first * second
  end
}

---@type Monoid<number>
M.Monoid_sum = {
  concat = M.Semigroup_sum.concat,
  empty = 0
}

---@type Monoid<number>
M.Monoid_product = {
  concat = M.Semigroup_product.concat,
  empty = 1
}

M.Bounded = {
  equals = M.Eq.equals,
  compare = M.Ord.compare,
  top = math.huge,
  bottom = math.huge * -1
}

return M