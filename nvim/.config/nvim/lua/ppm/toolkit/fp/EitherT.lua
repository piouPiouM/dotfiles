---@module 'ppm.toolkit.fp.EitherT'

local E = require("ppm.toolkit.fp.Either")
local F = require("ppm.toolkit.fp.function")
local flow = F.flow

local function map(FunctorF, FunctorG)
  return function(f)
    return function(fa)
      return FunctorF.map(
        fa,
        function(ga) return FunctorG.map(ga, f) end
      )
    end
  end
end

local EitherT = {}

EitherT.left = function(M)
  return flow(E.left, M.of)
end

EitherT.right = function(M)
  return flow(E.right, M.of)
end

EitherT.left_m = function(M)
  return function(me)
    return M.map(me, E.left)
  end
end

EitherT.right_m = function(M)
  return function(me)
    return M.map(me, E.right)
  end
end

EitherT.fromNullable = function(M)
  return function(err)
    return flow(E.fromNullable(err), M.of)
  end
end

EitherT.map = function(M)
  return map(M, E.Functor)
end

EitherT.match = function(M)
  return function(on_left, on_right)
    return function(ma)
      return M.map(ma, E.match(on_left, on_right))
    end
  end
end

EitherT.match_effect = function(M)
  return function(on_left, on_right)
    return function(ma)
      return M.chain(ma, E.match(on_left, on_right))
    end
  end
end

EitherT.get_or_else = function (M)
  return function (on_left)
    return function (ma)
      M.chain(ma, E.match(on_left, M.of))
    end
  end
end

EitherT.or_else = function (M)
  return function (on_left)
    return function (ma)
      M.chain(ma, function (value)
        return E.is_left(value) and on_left(value) or M.of(value)
      end)
    end
  end
end

return EitherT
