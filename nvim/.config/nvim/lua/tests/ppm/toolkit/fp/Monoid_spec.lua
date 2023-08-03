local N = require("ppm.toolkit.fp.number")
local S = require("ppm.toolkit.fp.string")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

describe("Monoid", function()
  local Module = require("ppm.toolkit.fp.Monoid")

  describe("concat_all()", function()
    it("should return the sum of the given array", function()
      local concat = Module.concat_all(N.Monoid_sum)
      assert.are.equals(3, concat({ 0, 1, 2 }))
      assert.are.equals(0, concat({ 0, 0, 0 }))
    end)

    it("should return the concatenation of strings", function()
      local concat = Module.concat_all(S.Monoid)
      assert.are.equals("hello world", concat({ "hello", " ", "world" }))
    end)
  end)

  describe("intercalate()", function()
    it("should concatenate the two strings with a glue", function()
      local instance = pipe(S.Monoid, Module.intercalate(":"))
      local actual = instance.concat("a", "b")
      assert.are.equals("a:b", actual)
    end)

    it("should be associative", function()
      local instance = pipe(S.Monoid, Module.intercalate(":"))
      assert.are.equals(
        instance.concat(instance.concat('a', 'b'), 'c'),
        instance.concat('a', instance.concat('b', 'c'))
      )
    end)

    it("should concatenate all array entries with a glue", function()
      local gluer = F.compose(Module.concat_all, Module.intercalate(":"))(S.Monoid)
      local actual = pipe({ "a", "b", "c", "d" }, gluer)
      assert.are.equals("a:b:c:d", actual)
    end)

    it("should sum all array entries and add 1 between each concatenation", function()
      local gluer = F.compose(Module.concat_all, Module.intercalate(1))(N.Monoid_sum)
      local actual = pipe({ 1, 1, 1 }, gluer)
      assert.are.equals(5, actual)
    end)
  end)
end)
