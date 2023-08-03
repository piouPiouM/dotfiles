local spy = require("luassert.spy")
local _u = require("tests.ppm.utils")

describe("Functions", function()
  local Module = require("ppm.toolkit.fp.function")

  describe("apply()", function()
    it("should increment the value", function()
      local actual = Module.apply(_u.addOne)(0)
      assert.are.equals(1, actual)
    end)
  end)

  describe("compose()", function()
    it("should return a new function by invoking the functions from right to left", function()
      local f = Module.compose(_u.double, _u.addOne)
      local actual = f(0)
      assert.are.equals(2, actual)
    end)
  end)

  describe("constant()", function()
    it("should return the argument of the first function", function()
      local expected = 0
      local actual = Module.constant(expected)(1)
      assert.are.equals(expected, actual)
    end)
  end)

  describe("constFalse()", function()
    it("should return a function that always returns false", function()
      local actual = Module.constFalse()
      assert.is_function(actual)
      assert.is_false(actual())
    end)
  end)

  describe("constTrue()", function()
    it("should return a function that always returns true", function()
      local actual = Module.constTrue()
      assert.is_function(actual)
      assert.is_true(actual())
    end)
  end)

  describe("constNil()", function()
    it("should return a function that always returns nil", function()
      local actual = Module.constNil()
      assert.is_function(actual)
      assert.is_nil(actual())
    end)
  end)

  describe("copy()", function()
    it("should create a shallow copy", function()
      local arr = { "a", "b" }
      local actual = Module.copy(arr)
      assert.are.same(arr, actual)
      assert.are.not_equals(arr, actual)

      actual[1] = "A"
      actual[3] = "c"
      assert.are.same({ "A", "b", "c" }, actual)
      assert.are.not_same(arr, actual)
    end)

    it("should create a shallow copy of nested table", function()
      local arr = { "a", { "b" } }
      local actual = Module.copy(arr)
      assert.are.same(arr, actual)
      assert.are.not_equals(arr, actual)

      actual[2][1] = "B"
      assert.are.same({ "a", { "B" } }, actual)
      assert.are.not_same(arr, actual)

      actual[2] = "c"
      assert.are.same({ "a", "c" }, actual)
      assert.are.not_same(arr, actual)
    end)
  end)

  describe("curry()", function()
    it("should be the same functions", function()
      local f = function(x)
        return x + 1
      end

      local expected = f(0)
      local actual = Module.curry(f)(0)

      assert.are.equals(1, expected)
      assert.are.equals(expected, actual)
    end)

    it("should produce the same result", function()
      local f = function(x, y, z)
        return x + y + z
      end
      local expected = f(0, 1, 2)
      local actual = Module.curry(f)(0)(1)(2)

      assert.are.equals(3, expected)
      assert.are.equals(expected, actual)
    end)

    it("should handle partial application for convenience", function()
      local f = function(x, y, z)
        return x + y + z
      end
      local actual = Module.curry(f)(0, 1)(2)

      assert.are.equals(3, actual)
    end)
  end)

  describe("foldm()", function()
    local NumberAdditionMonoid = {
      concat = function(a, b) return a + b end,
      empty = 0
    }

    it("should sum all values of the given arguments", function()
      local actual = Module.foldm(NumberAdditionMonoid)(1, 2, 3)
      assert.are.equals(6, actual)
    end)

    it("should return the `empty` value in absence of given values", function()
      local actual = Module.foldm(NumberAdditionMonoid)()
      assert.are.equals(0, actual)
    end)
  end)

  describe("flow()", function()
    it("should apply the given functions from left to right", function()
      assert.are.equals(2, Module.flow(_u.addOne)(1))
      assert.are.equals(4, Module.flow(_u.addOne, _u.double)(1))
      assert.are.equals(5, Module.flow(_u.addOne, _u.double, _u.addOne)(1))
      assert.are.equals(10, Module.flow(_u.addOne, _u.double, _u.addOne, _u.double)(1))
    end)

    it("should pass any arguments to the first function", function()
      local sum = function(a, b) return a + (b or 0) end
      assert.are.equals(2, Module.flow(sum)(1, 1))
      assert.are.equals(3, Module.flow(sum, _u.addOne)(1, 1))
      assert.are.equals(2, Module.flow(_u.addOne, sum)(1, 1))
    end)
  end)

  describe("identity()", function()
    it("should return the given argument", function()
      local actual = Module.identity(0)
      assert.are.equals(0, actual)
    end)

    it("should return the first argument given", function()
      local actual = Module.identity(0, 1)
      assert.are.equals(0, actual)
    end)
  end)

  describe("map()", function()
    it("should return a copy of table without transformation", function()
      local expected = { 1, 2, 3 }
      local actual = Module.map()({ 1, 2, 3 })
      assert.are.same(expected, actual)
      assert.are.not_equals(expected, actual)
    end)

    it("should double each value of the given array", function()
      local actual = Module.map(_u.double)({ 1, 2, 3 })
      assert.are.same({ 2, 4, 6 }, actual)
    end)

    it("should double each value of the given dictionary", function()
      local actual = Module.map(_u.double)({ a = 1, b = 2, c = 3 })
      assert.are.same({ a = 2, b = 4, c = 6 }, actual)
    end)

    it("should pass the value, index and collection at each iteration", function()
      local iteratee = spy.new(function(value) return value end)
      local collection = { 1, 2, 3 }

      ---@diagnostic disable-next-line: param-type-mismatch
      Module.map(iteratee)(collection)

      assert.spy(iteratee).was.called(3)
      assert.spy(iteratee).was.called_with(1, 1, collection)
      assert.spy(iteratee).was.called_with(2, 2, collection)
      assert.spy(iteratee).was.called_with(3, 3, collection)
    end)
  end)

  describe("pipe()", function()
    it("should supply the given value to the function and return the computed value", function()
      local actual = Module.pipe(0, _u.addOne)
      assert.are.equals(1, actual)
    end)

    it("should supply each function with the return value of the previous", function()
      local actual = Module.pipe(0, _u.addOne, _u.addOne, _u.addOne, _u.addOne)
      assert.are.equals(4, actual)
    end)
  end)

  describe("tap()", function()
    it("should return a function that always returns its argument", function()
      local actual = Module.tap(Module.identity)
      assert.is_function(actual)
      assert.are.equals(0, actual(0))
    end)

    it("may take a function as the first argument that executes with tap's argument", function()
      local sideEffect = 0
      local f = function(value)
        sideEffect = "casted to string: " .. value
      end
      local actual = Module.tap(f)(0)
      assert.are.equals(0, actual)
      assert.are.equals("casted to string: 0", sideEffect)
    end)
  end)
end)
