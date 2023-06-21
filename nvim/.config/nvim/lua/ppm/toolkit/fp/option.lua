--- `Option` encapsulates an optional value.
--- Either contains a value of type `A` (represented as `Some<A>`),
--- or it is empty (represented as `None`).
---@module 'ppm.toolkit.fp.option'

--- Encapsulates an optional value.
---
---@generic A
---@class Option<never>: { tag: "none" }
---@class Option<A>: { tag: "some", value: `A` }
local Option = {}

local mt = { __index = Option }

--- Returns a string representation of the Option.
---@generic A
---@param mo Option<A>
---@return string
mt.__tostring = function(mo)
  return Option.is_none(mo) and "None" or string.format("Some(%s)", mo.value)
end

---@internals
local function _is_option(t)
  return getmetatable(t) == mt
end

---@section constructors

-- Represents a missing value.
---
---@class None: { tag: "none" }
local NONE = setmetatable({ tag = "none" }, mt)

---Represents an optional value that exists.
---
---@generic A
---@param value A The value to wrap inside an Option.
---@return Option<A> option
local function some(value)
  local instance = {
    tag = "some",
    value = value
  }

  return setmetatable(instance, mt)
end

---@section Refinements

--- Returns `true` if the option is `None`, `false` otherwise.
---
---@generic A
---@param mo Option<A> The value to check.
---@return boolean # A boolean representing whether the param was a `None`.
local function is_none(mo)
  return _is_option(mo) and mo.tag == "none"
end

--- Returns `true` if the option is an instance of `Some`, `false` otherwise.
---
---@generic A
---@param mo Option<A> The value to check.
---@return boolean # A boolean representing whether the param was a `Some`.
local function is_some(mo)
  return _is_option(mo) and mo.tag == "some"
end

---@section Conversions

--- Wrap an object inside an Option.
---
--- Returns `Some(value)` if the provided value is non-nullable, `None` otherwise.
---
---@generic A
---@param value A The value to wrap.
---@return Option<A> mo An Option with the value wrapped inside.
---@see Option.of as an alias
---@see Option.unit as an alias
Option.fromNullable = function(value)
  return value == nil and NONE or some(value)
end

--- Extracts the value out of the `Option`, if it exists. Otherwise returns `nil`.
---
---@generic A
---@param mo Option<A>
---@return A | nil value
Option.toNullable = function(mo)
  assert(_is_option(mo), " not an Option")

  return is_none(mo) and nil or mo.value
end

---@section Lifting

-- Returns an Option based on the given predicate.
--
---@generic A
---@param predicate Predicate<A>
---@return fun(value: A): Option<A>
Option.fromPredicate = function(predicate)
  return function(value)
    return predicate(value) and some(value) or NONE
  end
end

---@section Mapping

--- Will apply the provided function to the unpacked value and will unpack a returned Option to avoid nested Options.
---
--- Common names: `>>=` (pronounced _bind_).
---
---@generic A
---@generic B
---@param f fun(value: A): Option<B> Function applied on the Option content.
---@return fun(mo: Option<A>): Option<B> # The result of the function f wrapped inside an Option.
---@see Option.bind as an alias.
---@see Option.chain as an alias.
Option.flatMap = function(f)
  return function(mo)
    return is_some(mo) and f(mo.value) or NONE
  end
end

--- Apply the function passed as parameter on the Option.
---
---@generic A
---@generic B
---@param f fun(value: A): B Function applied on the Option content.
---@return fun(mo: Option<A>): Option<B> # The result of the function `f` wrapped inside an Option.
---@see Option.fmap as an alias.
---@see Option.lift as an alias.
Option.map = function(f)
  return Option.flatMap(function(value)
    return Option.fromNullable(f(value))
  end)
end

--- Recursively unwraps nested Options and returns a `Option<T>`.
---
---@generic A
---@param nested Option<Option<A>> Nested options.
---@return Option<A> mo A single option.
Option.flatten = function(nested)
  assert(_is_option(nested), " not an Option")

  if is_none(nested) then
    return NONE
  end

  if _is_option(nested.value) then
    return Option.flatten(nested.value)
  end

  return nested
end

---@section Error handling

-- Returns the wrapped value if the value is a `Some`,
-- otherwise the result of the provided default callback will be returned.
---
---@generic A
---@generic B
---@param default fun(): B
---@return fun(mo: Option<A>): A | B value
Option.getOrElse = function(default)
  return function(mo)
    return is_some(mo) and mo.value or default()
  end
end

--- Provides a fallback for a given Option. Behaves like a logical `or`:
--- if the `mo` value is a `Some`, returns that `mo`; otherwise,
--- returns the result of the `elseFn` callback.
---
---@generic A
---@param elseFn fun(): Option<A> The function to apply if `mo` is `None`.
---@return fun(mo: Option<A>): Option<A>
Option.orElse = function(elseFn)
  return function(mo)
    return is_some(mo) and mo or elseFn()
  end
end

---@section Utils

--- Applies the function contained in the first `Some` to the value of the second `Some`, returning a `Some` of the result.
--- If either of the arguments are `None`, the result will be `None`.
Option.ap = function(mo)
  return function(fab)
    if is_none(fab) or is_none(mo) then
      return NONE
    end

    return some(fab.value(mo.value))
  end
end


-- Expose locals

Option.none = NONE
Option.some = some
Option.is_none = is_none
Option.is_some = is_some

-- Aliases

Option.of = Option.fromNullable
Option.unit = Option.fromNullable
Option.bind =  Option.flatMap
Option.chain = Option.flatMap
Option.fmap = Option.map
Option.lift = Option.map

return Option
