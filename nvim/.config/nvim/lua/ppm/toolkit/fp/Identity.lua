---@module 'ppm.toolkit.fp.Identity'

local Identity = {}
local mt = {
  __index = Identity,
  __tostring = function(ma)
    return ("Identity:: %s"):format(ma._value)
  end
}

Identity.of = function(value)
  return setmetatable({ _value = value }, mt)
end

Identity.map = function(f)
  return function(ma)
    return Identity.of(f(ma._value))
  end
end

return Identity
