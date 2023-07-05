--- Represents a value of one of two possible types to dealing with possible missing values.
--- `Left` is used for failure and `Right` is used for success.
---@module 'ppm.toolkit.fp.Either'

local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

---@generic E An error
---@generic A A success
---@class Left<E>: { tag: "left", left: E }
---@class Right<A>: { tag: "right", right: A }
---@alias Either<E, A> (Left<E> | Right<A>)
local Either = {}
Either.__index = Either

--- Returns a string representation of the Either object.
---
---@generic E
---@generic A
---@param ma Either<E, A>
---@return string
Either.__tostring = function(ma)
  return Either.match(
    function(left) return ("Either.left(%s)"):format(left) end,
    function(right) return ("Either.right(%s)"):format(right) end
  )(ma)
end

---@section Constructors

--- Wraps a value inside an Either Left object to indicate a failure.
---
---@generic E
---@param value E
---@return Left<E>
local function left(value)
  local instance = {
    tag = "left",
    left = value
  }

  return setmetatable(instance, Either)
end

--- Wraps a value inside an Either Right object to indicate a success.
---
---@generic A
---@param value A
---@return Right<A>
local function right(value)
  local instance = {
    tag = "right",
    right = value
  }

  return setmetatable(instance, Either)
end

---@section Refinements

--- Checks if the given object is a Either container.
---
local function is_either(self)
  return getmetatable(self) == Either
end

--- Checks if the given object is a Either Left container.
---
---@generic E
---@param value Either<E, unknown> The value to check.
---@return boolean # A boolean representing whether the param was a `None`.
local function is_left(value)
  return is_either(value) and value.tag == "left"
end

--- Checks if the given object is a Either Right container.
---
---@generic A
---@param value Either<unknown, A> The value to check.
---@return boolean # A boolean representing whether the param was a `None`.
---@see Either.of as an alias.
local function is_right(value)
  return is_either(value) and value.tag == "right"
end

---@section Conversions

--- Takes a default and a nullable value, if the value is not nully, turn it into a `Right`,
--- if the value is nully use the provided default as a `Left`.
---
---@generic A
---@generic E
---@param errorValue E
---@return fun(value: A): Either<E, A>
Either.fromNullable = function(errorValue)
  return function(value)
    return value == nil and left(errorValue) or right(value)
  end
end

Either.fromOption = function(errorValue)
  local O = require("ppm.toolkit.fp.Option")

  return function(ma)
    return O.is_none(ma) and left(errorValue) or right(ma.value)
  end
end

Either.toNullable = function(ma)
  return is_right(ma) and ma.right or nil
end

Either.toOption = function(ma)
  local O = require("ppm.toolkit.fp.Option")

  return right(ma) and O.some(ma.value) or O.none
end

---@section Lifting

Either.fromFalsy = function(errorValue)
  return function(value)
    return value and right(value) or left(errorValue)
  end
end

--- Returns an Option based on the given predicate.
---
Either.fromPredicate = function(predicate, errorValue)
  return function(value)
    return pipe(
      value,
      Either.fromNullable,
      Either.flatMap(function(v)
        return predicate(v) and right(v) or left(errorValue)
      end)
    )
  end
end

---@section Sequencing

---@generic A
---@generic B
---@generic E1
---@generic E2
---@param f fun(a: A): Either<E2, B>
---@return fun(ma: Either<E1, A>): Either<E1 | E2, B>
---@see Either.bind as an alias.
---@see Either.chain as an alias.
Either.flatMap = function(f)
  return function(ma)
    return is_left(ma) and ma or f(ma.right)
  end
end

---@generic A
---@generic E1
---@generic E2
---@diagnostic disable-next-line: undefined-doc-param
---@param mma Either<E1, Either<E2, A>>
---@return Either<E1 | E2, A> ma
Either.flatten = Either.flatMap(F.identity)

---@section Foldables

--- Left-associative fold of a structure.
---
---@generic A
---@generic B
---@generic E
---@param b B
---@param f fun(b: B, a: A): B
---@return fun(fa: Either<E,A>): B
Either.reduce = function(b, f)
  return function(fa)
    return is_left(fa) and b or f(b, fa.right)
  end
end

---@section Mapping

Either.map = function(f)
  return function(fa)
    return is_left(fa) and fa or right(f(fa.right))
  end
end

Either.mapLeft = function(f)
  return function(fa)
    return is_left(fa) and left(f(fa.left)) or fa
  end
end

---@section Error handling

---
---@generic E
---@generic A
---@generic B
---@param onLeft fun(e: E): B
---@return fun(ma: Either<E, A>): A | B
Either.getOrElse = function(onLeft)
  return function(ma)
    return is_left(ma) and onLeft(ma.left) or ma.right
  end
end

---
---@generic E1
---@generic E2
---@generic A
---@generic B
---@param onElse fun(): Either<E2, B>
---@return fun(ma: Either<E1, A>): Either<E1 | E2, A | B>
Either.orElse = function(onElse)
  return function(ma)
    return is_right(ma) and ma or onElse()
  end
end

---@generic E
---@generic A
---@generic B
---@param f LazyArg<A>
---@param on_failure fun(reason: unknown): E
---@return Either<E, A> ma
Either.try_catch = function(f, on_failure)
  local status, result = pcall(f)

  return status and right(result) or left(on_failure(result))
end

---@section Pattern matching

--- Takes two functions and an `Either` value, if the value is a `Left` the inner value is applied to the first function,
--- if the value is a `Right` the inner value is applied to the second function.
---
---@generic E
---@generic A
---@generic B
---@generic C
---@param onLeft fun(e: E): B
---@param onRight fun(a: A): C
---@return fun(ma: Either<E, A>): B | C
---@see Either.cata as an alias.
---@see Either.fold as an alias.
Either.match = function(onLeft, onRight)
  return function(ma)
    return is_left(ma) and onLeft(ma.left) or onRight(ma.right)
  end
end

---@section Utils

---@generic E1
---@generic E2
---@generic A
---@generic B
---@param fa Either<E2, A>
---@return fun(fab: Either<E1, fun(a: A): B>): Either<E1 | E2, B>
Either.ap = function(fa)
  return function(fab)
    return is_left(fab) and fab or is_left(fa) and fa or right(fab.right(fa.right))
  end
end

--- Apply the given predicate only if the value is a `Right`.
---
---@generic A
---@param predicate Predicate<A>
---@return fun(ma: Either<unknown, A>): boolean
Either.exists = function(predicate)
  return function(ma)
    if is_left(ma) then
      return false
    else
      return predicate(ma.right)
    end
  end
end

--- Returns a `Right` if is a `Left` and vice versa.
---
---@generic A
---@generic E
---@param ma Either<E, A>
---@return Either<A, E>
Either.swap = function(ma)
  return is_left(ma) and right(ma.left) or left(ma.right)
end

--- Applies a side-effect function to the value in `Right`, and returns the original Either.
---
---@generic E
---@generic A
---@param onRight fun(a: A)
---@return fun(ma: Either<E,A>): Either<E,A>
Either.tap = function(onRight)
  return function(ma)
    if is_right(ma) then
      onRight(ma.value)
    end

    return ma
  end
end

--- Applies a side-effect function to the value in `Left`, and returns the original Either.
---
---@generic E
---@generic A
---@param onLeft fun(a: A)
---@return fun(ma: Either<E,A>): Either<E,A>
Either.tapLeft = function(onLeft)
  return function(ma)
    if is_left(ma) then
      onLeft(ma.value)
    end

    return ma
  end
end

---@section Instances

---@generic E
---@generic A
---@param EqE Eq<E>
---@param EqA Eq<A>
---@return Eq<Either<E, A>>
Either.get_eq = function(EqE, EqA)
  return {
    ---@generic E
    ---@generic A
    ---@param first Either<E, A>
    ---@param second Either<E, A>
    equals = function(first, second)
      if first == second then
        return true
      end
      if is_left(first) then
        return is_left(second) and EqE.equals(first.left, second.left)
      end

      return is_right(second) and EqA.equals(first.right, second.right)
    end
  }
end

---@generic E
---@generic A
---@param semigroup Semigroup<A>
---@return Semigroup<Either<E, A>>
Either.get_semigroup = function(semigroup)
  return {
    ---@generic E
    ---@generic A
    ---@param first Either<E, A>
    ---@param second Either<E, A>
    concat = function(first, second)
      if is_left(second) then return first end
      if is_left(first) then return second end
      return right(semigroup.concat(first.right, second.right))
    end
  }
end

Either.Functor = {
  map = function(fa, f)
    return pipe(fa, Either.map(f))
  end
}

---@section Aliases

Either.of = right
Either.unit = right
Either.bind = Either.flatMap
Either.chain = Either.flatMap
Either.cata = Either.match
Either.fold = Either.match

-- Expose locals

Either.left = left
Either.right = right
Either.is_either = is_either
Either.is_left = is_left
Either.is_right = is_right

return Either
