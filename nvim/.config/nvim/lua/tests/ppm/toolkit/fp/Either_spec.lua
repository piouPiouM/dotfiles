local spy = require("luassert.spy")
local _u = require("tests.ppm.utils")
local fp = require("ppm.toolkit.fp.function")
local pipe = fp.pipe

describe("Either", function()
  local E = require("ppm.toolkit.fp.Either")
  local function _strlen(s) return E.right(string.len(s)) end

  describe("metamethods", function()
    describe("__tostring()", function()
      it("should return 'Either.left(0)'", function()
        local actual = tostring(E.left(0))
        assert.are.equals("Either.left(0)", actual)
      end)

      it("should return 'Either.right(1)'", function()
        local actual = tostring(E.right(1))
        assert.are.equals("Either.right(1)", actual)
      end)
    end)
  end)

  describe("constructors", function()
    describe("right()", function()
      it("should create a Right", function()
        local actual = E.right(1)
        assert.are.same({ tag = "right", right = 1 }, actual)
      end)
    end)

    describe("left()", function()
      it("should create a Left", function()
        local actual = E.left(0)
        assert.are.same({ tag = "left", left = 0 }, actual)
      end)
    end)
  end)

  describe("converters", function()
    describe("fromNullable()", function()
      it("should encapsulate the not nullable value to a Some", function()
        local actual = pipe(1, E.fromNullable(0))
        assert.are.same(E.right(1), actual)
      end)

      it("should return a None when the value is nullable", function()
        local actual = pipe(nil, E.fromNullable(0))
        assert.are.same(E.left(0), actual)
      end)
    end)

    describe("toNullable()", function()
      it("should return nil", function()
        assert.is_nil(E.toNullable(E.left(0)))
      end)

      it("should return the encapsulated value", function()
        assert.is.not_nil(E.toNullable(E.right(1)))
      end)
    end)
  end)

  describe("pipeables", function()
    describe("ap()", function()
      it("should apply double() encapsulated by a Right", function()
        local actual = pipe(E.right(_u.double), E.ap(E.right(1)))
        assert.are.same(E.right(2), actual)
      end)

      it("should return a Left", function()
        assert.are.same(E.left(0), pipe(E.right(_u.double), E.ap(E.left(0))))
        assert.are.same(E.left(0), pipe(E.left(0), E.ap(E.right(1))))
        assert.are.same(E.left(0), pipe(E.left(0), E.ap(E.left(1))))
      end)
    end)

    describe("exists()", function()
      local is_positive = spy.new(function(n) return n > 0 end)

      it("should return false when the Either object is a Left", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.left(1), E.exists(is_positive))
        assert.is_false(actual)
        assert.spy(is_positive).was.not_called()
      end)

      it("should return false when the predicate returns false", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.right(0), E.exists(is_positive))
        assert.is_false(actual)
        assert.spy(is_positive).was.called_with(0)
      end)

      it("should return true when the predicate returns true", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.right(1), E.exists(is_positive))
        assert.is_true(actual)
        assert.spy(is_positive).was.called_with(1)
      end)
    end)

    describe("flatMap()", function()
      it("should return 3 wrapped by a Right", function()
        local actual = pipe(E.right('abc'), E.flatMap(_strlen))
        assert.are.same(E.right(3), actual)
      end)

      it("should return the given Left", function()
        local expected = E.left(0)
        local actual = pipe(expected, E.flatMap(_strlen))
        assert.are.equals(expected, actual)
      end)
    end)

    describe("flatten()", function()
      it("should unwraps nested Right", function()
        local actual = pipe(E.right(E.right(1)), E.flatten)
        assert.are.same(E.right(1), actual)
      end)

      it("should return the nested Left", function()
        local expected = E.left(0)
        local actual = pipe(E.right(expected), E.flatten)
        assert.are.equals(expected, actual)
      end)
    end)

    describe("getOrElse()", function()
      it("should return the value contained in the Right", function()
        local actual = pipe(E.right(1), E.getOrElse(function() return 0 end))
        assert.equal(1, actual)
      end)

      it("should return the defaut value", function()
        local actual = pipe(E.left(1), E.getOrElse(function() return 0 end))
        assert.equal(0, actual)
      end)
    end)

    describe("map()", function()
      local f

      before_each(function()
        f = spy.new(_u.double)
      end)

      it("should double the content and return it inside a Right", function()
        local actual = pipe(E.right(1), E.map(f))
        assert.are.same(E.right(2), actual)
        assert.spy(f).was.called()
      end)

      it("should return the untouched Left", function()
        local expected = E.left(1)
        local actual = pipe(expected, E.map(f))
        assert.are.equals(expected, actual)
        assert.spy(f).was.not_called()
      end)
    end)

    describe("mapLeft()", function()
      local f

      before_each(function()
        f = spy.new(_u.double)
      end)

      it("should double the content and return it inside a Left", function()
        local actual = pipe(E.left(1), E.mapLeft(f))
        assert.are.same(E.left(2), actual)
        assert.spy(f).was.called()
      end)

      it("should return the untouched Right", function()
        local expected = E.right(1)
        local actual = pipe(expected, E.mapLeft(f))
        assert.are.equals(expected, actual)
        assert.spy(f).was.not_called()
      end)
    end)

    describe("match()", function()
      local onLeft, onRight

      before_each(function()
        onLeft = spy.new(_u.subOne)
        onRight = spy.new(_u.addOne)
      end)

      it("should apply onLeft callback on the Left", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.left(1), E.match(onLeft, onRight))
        assert.are.equals(0, actual)
        assert.spy(onLeft).was.called_with(1)
        assert.spy(onRight).was.not_called()
      end)

      it("should apply onRight callback on the Right", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.right(1), E.match(onLeft, onRight))
        assert.are.equals(2, actual)
        assert.spy(onRight).was.called_with(1)
        assert.spy(onLeft).was.not_called()
      end)
    end)

    describe("onError()", function()
      local onElseLeft, onElseRight

      before_each(function()
        onElseLeft = spy.new(function() return E.left(0) end)
        onElseRight = spy.new(function() return E.right(2) end)
      end)

      it("should return the inital Right without calling the Left callbacked", function()
        local expected = E.right(1)
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(expected, E.orElse(onElseLeft))
        assert.are.equals(expected, actual)
        assert.spy(onElseLeft).was.not_called()
      end)

      it("should return the inital Right without calling the Right callbacked", function()
        local expected = E.right(1)
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(expected, E.orElse(onElseRight))
        assert.are.equals(expected, actual)
        assert.spy(onElseRight).was.not_called()
      end)

      it("should return the Right callbacked when the initial value is a Left", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.left(0), E.orElse(onElseRight))
        assert.are.same(E.right(2), actual)
        assert.spy(onElseRight).was.called()
      end)

      it("should return the Left callbacked when the initial value is a Left", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(E.left(1), E.orElse(onElseLeft))
        assert.are.same(E.left(0), actual)
        assert.spy(onElseLeft).was.called()
      end)
    end)

    describe("reduce()", function()
      local function concat(acc, a) return acc .. a end

      it("should return the result of the callback", function()
        local actual = pipe(E.right("bar"), E.reduce("foo", concat))
        assert.are.equals("foobar", actual)
      end)

      it("should ignore the Left", function()
        local actual = pipe(E.left("bar"), E.reduce("foo", concat))
        assert.are.equals("foo", actual)
      end)
    end)
  end)

  describe("error handlers", function()
    describe("tryCatch()", function()
      local function onFailure() return "Error" end

      it("should return the result of the given function inside a Right", function()
        local actual = E.tryCatch(function() return 1 end, onFailure)
        assert.are.same(E.right(1), actual)
      end)

      it("should return the result of the onFailure function inside a Left", function()
        local actual = E.tryCatch(function() error(0) end, onFailure)
        assert.are.same(E.left("Error"), actual)
      end)
    end)
  end)

  describe("utils", function()
    describe("swap()", function()
      it("should turn Right into Left", function()
        local actual = E.swap(E.right(1))
        assert.are.same(E.left(1), actual)
      end)

      it("should turn Left into Right", function()
        local actual = E.swap(E.left(0))
        assert.are.same(E.right(0), actual)
      end)
    end)
  end)

  _u.generateAliasesTests(E, {
    ["right"] = { "of", "unit" },
    ["flatMap"] = { "bind", "chain" },
    ["match"] = { "cata", "fold" },
  })
end)
