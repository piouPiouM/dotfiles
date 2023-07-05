---@module 'ppm.toolkit.fp.IOEither'

local E = require("ppm.toolkit.fp.Either")
local ET = require("ppm.toolkit.fp.EitherT")
local IO = require("ppm.toolkit.fp.IO")
local F = require("ppm.toolkit.fp.function")

---@alias IOEither<E, A> IO<Either<E, A>>

local IOEither = {}

---@section Constructors

IOEither.left = ET.left(IO.Pointed)

IOEither.right = ET.right(IO.Pointed)

IOEither.left_IO = ET.left_m(IO.Functor)

IOEither.right_IO = ET.right_m(IO.Functor)

---@section Conversions

IOEither.from_either = IO.of

IOEither.from_IO = IOEither.right_IO

IOEither.match = ET.match(IO.Functor)

IOEither.match_effect = ET.match_effect(IO.Monad)

---@generic E
---@generic A
---@generic B
---@param f LazyArg<A>
---@param on_failure fun(reason: unknown): E
---@return IOEither<E, A>
IOEither.try_catch = function(f, on_failure)
  return function()
    return E.try_catch(f, on_failure)
  end
end

IOEither.get_or_else = ET.get_or_else(IO.Monad)

IOEither.or_else = ET.or_else(IO.Monad)

---@section Aliases

IOEither.of = IOEither.right

return IOEither
