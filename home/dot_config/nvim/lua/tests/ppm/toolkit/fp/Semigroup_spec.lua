local B = require("ppm.toolkit.fp.boolean")
local F = require("ppm.toolkit.fp.function")
local N = require("ppm.toolkit.fp.number")
local S = require("ppm.toolkit.fp.string")
local pipe = F.pipe

describe("Semigroup", function()
  local Module = require("ppm.toolkit.fp.Semigroup")

  describe("contructors", function()
    describe("min()", function()
      it("should return the lowest number", function()
        local instance = Module.min(N.Ord)
        local actual = instance.concat(1, 2)
        assert.are.equals(1, actual)
      end)

      it("should return the lowest number too", function()
        local instance = Module.min(N.Ord)
        local actual = instance.concat(2, 1)
        assert.are.equals(1, actual)
      end)
    end)

    describe("max()", function()
      it("should return the greater number", function()
        local instance = Module.max(N.Ord)
        local actual = instance.concat(1, 2)
        assert.are.equals(2, actual)
      end)

      it("should return the greater number too", function()
        local instance = Module.max(N.Ord)
        local actual = instance.concat(2, 1)
        assert.are.equals(2, actual)
      end)
    end)
  end)

  describe("combinators", function()
    describe("intercalate()", function()
      it("should concatenate the two strings with a glue", function()
        local instance = pipe(S.Semigroup, Module.intercalate(":"))
        local actual = instance.concat("a", "b")
        assert.are.equals("a:b", actual)
      end)

      it("should be associative", function()
        local instance = pipe(S.Semigroup, Module.intercalate(":"))
        assert.are.equals(
          instance.concat(instance.concat('a', 'b'), 'c'),
          instance.concat('a', instance.concat('b', 'c'))
        )
      end)

      it("should concatenate all array entries with a glue", function()
        local glue = pipe(S.Semigroup, Module.intercalate(":"))
        local actual = pipe({ "a", "b", "c", "d" }, Module.concat_all(glue)(""))
        assert.are.equals(":a:b:c:d", actual)
      end)
    end)

    describe("reverse()", function()
      it("should concatenate the two strings in reverse order", function()
        local instance = Module.reverse(S.Semigroup)
        local actual = instance.concat("a", "b")
        assert.are.equals("ba", actual)
      end)

      it("should substract the two numbers in reverse order", function()
        local instance = Module.reverse(N.Magma_sub)
        assert.are.equals(1, instance.concat(1, 2))
        assert.are.equals(-1, instance.concat(2, 1))
      end)
    end)

    describe("struct()", function()
      it("should apply the result of `concat` on each properties", function()
        local instance = Module.struct({
          name = S.Semigroup,
          counter = N.Semigroup_sum,
        })
        local obj1 = { name = "a", counter = 1 }
        local obj2 = { name = "b", counter = 2 }
        assert.are.same({ name = "ab", counter = 3 }, instance.concat(obj1, obj2))
      end)
    end)

    describe("tuple()", function()
      it("should apply the result of `concat` on corresponding entries", function()
        local instance = Module.tuple(S.Semigroup, N.Semigroup_sum, B.Semigroup_all)
        local arr1 = { "a", 1, true }
        local arr2 = { "b", 2, false }
        assert.are.same({ "ab", 3, false }, instance.concat(arr1, arr2))
      end)
    end)

    describe("concat_all()", function()
      it("should return the sum of the given array", function()
        local concat = Module.concat_all(N.Semigroup_sum)(0)
        assert.are.equals(3, concat({ 0, 1, 2 }))
        assert.are.equals(0, concat({ 0, 0, 0 }))
      end)

      it("should return the sum of the given array from the initial value", function()
        local concat = Module.concat_all(N.Semigroup_sum)(20)
        assert.are.equals(23, concat({ 0, 1, 2 }))
        assert.are.equals(20, concat({ 0, 0, 0 }))
      end)

      it("should return the concatenation of strings", function()
        local concat = Module.concat_all(S.Semigroup)("")
        assert.are.equals("hello world", concat({ "hello", " ", "world" }))
      end)
    end)
  end)
end)
