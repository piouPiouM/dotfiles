local spy = require("luassert.spy")
local fp = require("ppm.toolkit.fp.function")
local B = require("ppm.toolkit.fp.boolean")
local N = require("ppm.toolkit.fp.number")
local S = require("ppm.toolkit.fp.string")
local pipe = fp.pipe

describe("Eq", function()
  local Eq = require("ppm.toolkit.fp.Eq")

  describe("constructors", function()
    describe("fromEquals()", function()
      local arr1, arr2, callback, comparator

      before_each(function()
        arr1 = { "a" }
        arr2 = { "a" }
        callback = spy.new(function(x, y)
          return x[1] == y[1]
        end)
        comparator = Eq.fromEquals(callback)
      end)

      it("should not calls the given function when arguments are the sames", function()
        assert.is_true(comparator.equals(arr1, arr1))
        assert.spy(callback).called(0)
      end)

      it("should call the function and returns true", function()
        assert.is_true(comparator.equals(arr1, arr2))
        assert.spy(callback).called(1)
      end)

      it("should call the function and returns false", function()
        arr2 = { "b" }
        assert.is_false(comparator.equals(arr1, arr2))
        assert.spy(callback).called(1)
      end)
    end)
  end)

  describe("combinators", function()
    describe("struct()", function ()
      it("should perform the equality on each properties according the corresponding Eq instance", function ()
        local comparator = Eq.struct({
          name = S.Eq,
          age = N.Eq
        })
        assert.is_true(comparator.equals(
          { name = "a", age = 1 },
          { name = "a", age = 1 }
        ))
        assert.is_false(comparator.equals(
          { name = "a", age = 1 },
          { name = "b", age = 1 }
        ))
        assert.is_false(comparator.equals(
          { name = "a", age = 1 },
          { name = "a", age = 2 }
        ))
        assert.is_false(comparator.equals(
          { name = "a", age = 1 },
          { name = "b", age = 2 }
        ))
      end)
    end)

    describe("tuple()", function()
      local string_number_boolean = Eq.tuple(S.Eq, N.Eq, B.Eq)

      it("should return true when pairwise entries validate the corresponding Eq instance", function()
        assert.is_true(string_number_boolean.equals({ "a", 1, true }, { "a", 1, true }))
      end)

      it("should return false when pairwise entries do not validate the corresponding Eq instance", function()
        assert.is_false(string_number_boolean.equals({ "a", 1, true }, { "b", 1, true }))
        assert.is_false(string_number_boolean.equals({ "a", 1, true }, { "a", 2, true }))
        assert.is_false(string_number_boolean.equals({ "a", 1, true }, { "a", 1, false }))
      end)
    end)
  end)

  describe("pipeables", function()
    describe("contramap()", function ()
      local byAge = function (person)
        return person.age
      end
      local adaptator = pipe(N.Eq, Eq.contramap(byAge))

      it("should return true when the `age` of given objects are equals", function ()
        assert.is_true(adaptator.equals(
          { name = "a", age = 1 },
          { name = "a", age = 1 }
        ))
        assert.is_true(adaptator.equals(
          { name = "a", age = 1 },
          { name = "b", age = 1 }
        ))
      end)

      it("should return false when the `age` of given objects are not equals", function ()
        assert.is_false(adaptator.equals(
          { name = "a", age = 1 },
          { name = "a", age = 2 }
        ))
        assert.is_false(adaptator.equals(
          { name = "a", age = 1 },
          { name = "b", age = 2 }
        ))
      end)
    end)
  end)
end)
