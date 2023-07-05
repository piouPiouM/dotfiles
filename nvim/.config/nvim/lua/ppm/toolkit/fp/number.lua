local M = {}

---@section Instances

---@type Eq<number>
M.Eq = {
  equals = function(first, second) return first == second end
}

---@type Semigroup<number>
M.semigroup_max = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return math.max(first, second)
  end
}

---@type Semigroup<number>
M.semigroup_min = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return math.min(first, second)
  end
}

---@type Magma<number>
M.magma_sub = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first - second
  end
}

---@type Semigroup<number>
M.semigroup_sum = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first + second
  end
}

---@type Semigroup<number>
M.semigroup_product = {
  ---@param first number
  ---@param second number
  ---@return number
  concat = function(first, second)
    return first * second
  end
}

---@type Monoid<number>
M.monoid_sum = {
  concat = M.semigroup_sum.concat,
  empty = 0
}

---@type Monoid<number>
M.monoid_product = {
  concat = M.semigroup_product.concat,
  empty = 1
}

return M
