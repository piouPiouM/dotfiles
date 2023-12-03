local spy = require("luassert.spy")
local _u = require("tests.ppm.utils")
local fp = require("ppm.toolkit.fp.function")
local pipe = fp.pipe


describe("Option", function()
  local Option = require("ppm.toolkit.fp.Option")
  local none, some = Option.none, Option.some

  describe("metamethods", function()
    describe("__tostring()", function()
      it("should return 'None' for missing value", function()
        local actual = tostring(none)
        assert.are.equals("None", actual)
      end)

      it("should return 'Some(0)' for an existing value", function()
        local actual = tostring(some(0))
        assert.are.equals("Some(0)", actual)
      end)
    end)
  end)

  describe("constructors", function()
    it("should return a None", function()
      assert.are.same({ tag = "none" }, none)
    end)

    it("should return a Some", function()
      assert.are.same({ value = 0, tag = "some" }, some(0))
    end)
  end)

  describe("refiners", function()
    describe("is_none()", function()
      it("should be true when the given value is a None", function()
        local actual = Option.is_none(none)
        assert.is_true(actual)
      end)

      it("should be false when the given value is a Some", function()
        local actual = Option.is_none(some(0))
        assert.is_false(actual)
      end)
    end)

    describe("is_some()", function()
      it("should be true when the given value is a Some", function()
        local actual = Option.is_some(some(0))
        assert.is_true(actual)
      end)

      it("should be false when the given value is a None", function()
        local actual = Option.is_some(none)
        assert.is_false(actual)
      end)
    end)
  end)

  describe("converters", function()
    describe("fromNullable()", function()
      it("should encapsulate the not nullable value to a Some", function()
        local actual = Option.fromNullable(0)
        assert.are.same(some(0), actual)
      end)

      it("should return a None when the value is nullable", function()
        local actual = Option.fromNullable(nil)
        assert.are.same(none, actual)
      end)
    end)

    describe("toNullable()", function()
      it("should return nil", function()
        assert.is_nil(Option.toNullable(none))
      end)

      it("should return the encapsulated value", function()
        assert.is.not_nil(Option.toNullable(some(0)))
      end)
    end)
  end)

  describe("pipeables", function()
    describe("ap()", function()
      it("should apply double() to the encapsulated value", function()
        local actual = pipe(some(_u.double), Option.ap(some(2)))
        assert.are.same(some(4), actual)
      end)

      it("should return a None", function()
        assert.are.same(none, pipe(some(_u.double), Option.ap(none)))
        assert.are.same(none, pipe(none, Option.ap(some(0))))
        assert.are.same(none, pipe(none, Option.ap(none)))
      end)
    end)

    describe("filter()", function()
      local predicate = function(value)
        return 0 == value
      end

      it("should return a None when the predicate is falsy", function()
        local actual = pipe(some(1), Option.filter(predicate))
        assert.are.same(none, actual)
        assert.are.same(none, pipe(none, Option.filter(predicate)))
      end)

      it("should return a None when the object to filter is a None", function()
        local actual = pipe(none, Option.filter(predicate))
        assert.are.same(none, actual)
      end)

      it("should return the given Some", function()
        local original = some(0)
        local actual = pipe(original, Option.filter(predicate))
        assert.are.equals(original, actual)
      end)
    end)


    describe("flatMap()", function()
      local function f(n) return some(_u.double(n)) end
      local function g() return none end

      it("should double the encapsulated value", function()
        local actual = pipe(some(1), Option.flatMap(f))
        assert.are.same(some(2), actual)
      end)

      it("should return a None", function()
        assert.are.same(none, pipe(none, Option.flatMap(f)))
        assert.are.same(none, pipe(some(0), Option.flatMap(g)))
        assert.are.same(none, pipe(none, Option.flatMap(g)))
      end)
    end)

    describe("flatten()", function()
      it("should only accept an Option", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        assert.is.error(function()
          return pipe(0, Option.flatten)
        end
        )
      end)

      it("should unwraps nested Some", function()
        assert.are.same(some(0), pipe(some(some(0)), Option.flatten))
        assert.are.same(some(0), pipe(some(some(some(0))), Option.flatten))
      end)

      it("should return None", function()
        assert.are.same(none, pipe(none, Option.flatten))
        assert.are.same(none, pipe(some(none), Option.flatten))
      end)
    end)

    describe("fromPredicate()", function()
      it("should return a None when the predicate resolves false", function()
        local predicate = function(value)
          return 0 == value
        end
        local actual = Option.fromPredicate(predicate)
        assert.is_function(actual)
        assert.are.same(none, actual(1))
      end)

      it("should return the value wrapped in a Some when the predicate resolves true", function()
        local predicate = function(value)
          return 0 == value
        end
        local actual = Option.fromPredicate(predicate)
        assert.is_function(actual)
        assert.are.same(some(0), actual(0))
      end)
    end)

    describe("getOrElse()", function()
      it("should return the encapsulated value", function()
        local actual = pipe(some(1), Option.getOrElse(function() return 0 end))
        assert.equal(1, actual)
      end)

      it("should return the defaut value", function()
        local actual = pipe(none, Option.getOrElse(function() return 0 end))
        assert.equal(0, actual)
      end)
    end)

    describe("map()", function()
      it("should add 1 to the value encapsulated in a Some", function()
        local actual = pipe(some(0), Option.map(_u.addOne))
        assert.are.same(some(1), actual)
      end)

      it("should return a None", function()
        local actual = pipe(none, Option.map(_u.addOne))
        assert.are.same(none, actual)
      end)
    end)

    describe("orElse()", function()
      it("should return the given Option, without calling the callback", function()
        local callback = spy.new(function() return some(0) end)
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(some(1), Option.orElse(callback))
        assert.are.same(some(1), actual)
        assert.spy(callback).was_not.called()
        callback:revert()
      end)

      it("should call the callback and returns branched Option", function()
        local callback = spy.new(function() return some(0) end)
        ---@diagnostic disable-next-line: param-type-mismatch
        local actual = pipe(none, Option.orElse(callback))
        assert.are.same(some(0), actual)
        assert.spy(callback).was.called()
        callback:revert()
      end)
    end)
  end)

  _u.generateAliasesTests(Option, {
    ["fromNullable"] = { "of", "unit" },
    ["flatMap"] = { "bind", "chain" },
    ["map"] = { "fmap", "lift" },
  })
end)
