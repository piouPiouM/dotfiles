local _u = require("tests.ppm.utils")

describe("Functions", function()
  local F = require("ppm.toolkit.fp.function")

  describe("apply()", function ()
    it("should increment the value", function ()
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
    it("should return the argument of the first function", function ()
      local expected = 0
      local actual = F.constant(expected)(1)
      assert.are.equals(expected, actual)
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

  describe("tap()", function ()
    it("should return a function that always returns its argument", function ()
      local actual = F.tap(F.identity)
      assert.is_function(actual)
      assert.are.equals(0, actual(0))
    end)

    it("may take a function as the first argument that executes with tap's argument", function()
      local sideEffect = 0
      local f = function (value)
        sideEffect = 'casted to string: ' .. value
      end
      local actual = F.tap(f)(0)
      assert.are.equals(0, actual)
      assert.are.equals('casted to string: 0', sideEffect)
    end)
  end)
end)
