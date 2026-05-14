---@module 'ppm.toolkit.fp.IO'

local F = require("ppm.toolkit.fp.function")

---@alias IO<A> fun(): A

local IO = {}

local map = function(ma, f)
  return function()
    return f(ma())
  end
end

local ap = function(mab, ma)
  return function()
    return mab()(ma())
  end
end

---@section Constructors

---@generic A
---@diagnostic disable-next-line: undefined-doc-param
---@param a A
---@return IO<A>
IO.of = F.constant

---@generic A
---@generic B
---@param f fun(a: A): B
---@return fun(fa: IO<A>): IO<B>
IO.map = function(f)
  return function(fa)
    return map(fa, f)
  end
end

---@generic A
---@generic B
---@param fa IO<A>
---@return fun(fab: IO<fun(a: A): B>): IO<B>
IO.ap = function(fa)
  return function(fab)
    return ap(fab, fa)
  end
end

---@generic A
---@generic B
---@param f fun(a: A): IO<B>
---@return fun(fa: IO<A>): IO<B>
IO.flatmap = function(f)
  return function(fa)
    return function()
      return f(fa())()
    end
  end
end

IO.flatten = IO.flatmap(F.identity)

IO.Pointed = {
  of = IO.of
}

IO.Functor = {
  map = map
}

IO.Monad = {
  map = map,
  of = IO.of,
  ap = ap,
  chain = IO.flatmap,
}

return IO
