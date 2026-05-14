---@module 'ppm.toolkit.fp.Identity'

---@class Identity<A>
local Identity = {}

---@generic A
---@param value A
---@return Identity<A>
Identity.of = function(value)
  return value
end

---@generic A
---@generic B
---@return Identity<A | B>
Identity.alt = function(_)
  return Identity.of
end

---@generic A
---@generic B
---@param fa Identity<A>
---@return fun(fab: Identity<fun(a: A): B>): Identity<B>
Identity.ap = function (fa)
  return function (fab)
    return fab(fa)
  end
end

---@generic A
---@generic B
---@param f fun(a: A): B
---@return fun(fa: Identity<A>): Identity<B>
Identity.map = function(f)
  return function(fa)
    return f(fa)
  end
end

return Identity
