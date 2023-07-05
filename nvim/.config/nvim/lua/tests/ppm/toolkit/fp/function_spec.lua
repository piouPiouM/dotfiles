local spy = require("luassert.spy")
local _u = require("tests.ppm.utils")

describe("Functions", function()
  local F = require("ppm.toolkit.fp.function")

  describe("apply()", function()
    it("should increment the value", function()
      local actual = F.apply(_u.addOne)(0)
      assert.are.equals(1, actual)
    end)
  end)

  describe("compose()", function()
    it("should return a new function by invoking the functions from right to left", function()
      local f = F.compose(_u.double, _u.addOne)
      local actual = f(0)
      assert.are.equals(2, actual)
    end)
  end)

  describe("constant()", function()
    it("should return the argument of the first function", function()
      local expected = 0
      local actual = F.constant(expected)(1)
      assert.are.equals(expected, actual)
    end)
  end)

  describe("constFalse()", function()
    it("should return a function that always returns false", function()
      local actual = F.constFalse()
      assert.is_function(actual)
      assert.is_false(actual())
    end)
  end)

  describe("constTrue()", function()
    it("should return a function that always returns true", function()
      local actual = F.constTrue()
      assert.is_function(actual)
      assert.is_true(actual())
    end)
  end)

  describe("constNil()", function()
    it("should return a function that always returns nil", function()
      local actual = F.constNil()
      assert.is_function(actual)
      assert.is_nil(actual())
    end)
  end)

  describe("curry()", function()
    it("should be the same functions", function()
      local f = function(x)
        return x + 1
      end

      local expected = f(0)
      local actual = F.curry(f)(0)

      assert.are.equals(1, expected)
      assert.are.equals(expected, actual)
    end)

    it("should produce the same result", function()
      local f = function(x, y, z)
        return x + y + z
      end
      local expected = f(0, 1, 2)
      local actual = F.curry(f)(0)(1)(2)

      assert.are.equals(3, expected)
      assert.are.equals(expected, actual)
    end)

    it("should handle partial application for convenience", function()
      local f = function(x, y, z)
        return x + y + z
      end
      local actual = F.curry(f)(0, 1)(2)

      assert.are.equals(3, actual)
    end)
  end)

  describe("foldm()", function()
    local NumberAdditionMonoid = {
      concat = function(a, b) return a + b end,
      empty = 0
    }

    it("should sum all values of the given arguments", function()
      local actual = F.foldm(NumberAdditionMonoid)(1, 2, 3)
      assert.are.equals(6, actual)
    end)

    it("should return the `empty` value in absence of given values", function()
      local actual = F.foldm(NumberAdditionMonoid)()
      assert.are.equals(0, actual)
    end)
  end)

  describe("identity()", function()
    it("should return the given argument", function()
      local actual = F.identity(0)
      assert.are.equals(0, actual)
    end)

    it("should return the first argument given", function()
      local actual = F.identity(0, 1)
      assert.are.equals(0, actual)
    end)
  end)

  describe("map()", function()
    it("should return a copy of table without transformation", function()
      local expected = { 1, 2, 3 }
      local actual = F.map()({ 1, 2, 3 })
      assert.are.same(expected, actual)
      assert.are.not_equals(expected, actual)
    end)

    it("should double each value of the given array", function()
      local actual = F.map(_u.double)({ 1, 2, 3 })
      assert.are.same({ 2, 4, 6 }, actual)
    end)

    it("should double each value of the given dictionary", function()
      local actual = F.map(_u.double)({ a = 1, b = 2, c = 3 })
      assert.are.same({ a = 2, b = 4, c = 6 }, actual)
    end)

    it("should pass the value, index and collection at each iteration", function()
      local iteratee = spy.new(function(value) return value end)
      local collection = { 1, 2, 3 }

      ---@diagnostic disable-next-line: param-type-mismatch
      F.map(iteratee)(collection)

      assert.spy(iteratee).was.called(3)
      assert.spy(iteratee).was.called_with(1, 1, collection)
      assert.spy(iteratee).was.called_with(2, 2, collection)
      assert.spy(iteratee).was.called_with(3, 3, collection)
    end)
  end)

  describe("pipe()", function()
    it("should supply the given value to the function and return the computed value", function()
      local actual = F.pipe(0, _u.addOne)
      assert.are.equals(1, actual)
    end)

    it("should supply each function with the return value of the previous", function()
      local actual = F.pipe(0, _u.addOne, _u.addOne, _u.addOne, _u.addOne)
      assert.are.equals(4, actual)
    end)
  end)

  describe("tap()", function()
    it("should return a function that always returns its argument", function()
      local actual = F.tap(F.identity)
      assert.is_function(actual)
      assert.are.equals(0, actual(0))
    end)

    it("may take a function as the first argument that executes with tap's argument", function()
      local sideEffect = 0
      local f = function(value)
        sideEffect = "casted to string: " .. value
      end
      local actual = F.tap(f)(0)
      assert.are.equals(0, actual)
      assert.are.equals("casted to string: 0", sideEffect)
    end)
  end)
end)
