local spy = require("luassert.spy")
local O = require("ppm.toolkit.fp.Option")
local fp = require("ppm.toolkit.fp.function")
local pipe = fp.pipe

describe("Array", function()
  local A = require("ppm.toolkit.fp.Array")

  describe("constructors", function()
    describe("of()", function()
      it("should return an array with the given value", function()
        local actual = A.of(1)
        assert.are.same({ 1 }, actual)
        assert.are.equals(1, actual[1])
      end)

      it("should return an array with the given nil", function()
        local actual = A.of(nil)
        assert.are.same({ nil }, actual)
        assert.are.equals(nil, actual[1])
      end)
    end)

    describe("zero()", function()
      it("should return an empty array", function()
        local actual = A.zero()
        assert.are.same({}, actual)
        assert.are.equals(0, #actual)
      end)
    end)
  end)

  describe("refiners", function()
    describe("is_empty()", function()
      it("should return true when the given array is empty", function()
        local actual = A.is_empty({})
        assert.is_true(actual)
      end)

      it("should return false when the given array contains entries", function()
        local actual = A.is_empty({ 1 })
        assert.is_false(actual)
      end)
    end)
  end)

  describe("converters", function()
    describe("fromOption()", function()
      it("should return an empty array when the given Option is a None", function()
        local actual = A.fromOption(O.none)
        assert.are.same({}, actual)
      end)

      it("should return an array with the content of the given Some", function()
        local actual = A.fromOption(O.some(0))
        assert.are.same({ 0 }, actual)
      end)
    end)
  end)

  describe("pipeables", function()
    describe("concat()", function()
      it("should return a copy of the second array when the first is empty", function()
        local second = { 2 }
        local actual = pipe({}, A.concat(second))
        assert.are.same({ 2 }, actual)
        assert.are.not_equals(second, actual)
      end)

      it("should return a copy of the first array when the second is empty", function()
        local first = { 1 }
        local actual = pipe({}, A.concat(first))
        assert.are.same({ 1 }, actual)
        assert.are.not_equals(first, actual)
      end)

      it("should return an array with the values of the two given arrays", function()
        local actual = pipe({ 1 }, A.concat({ 2 }))
        assert.are.same({ 1, 2 }, actual)
      end)

      it("should return an array with mixed types", function()
        local actual = pipe({ 1 }, A.concat({ "a" }))
        assert.are.same({ 1, "a" }, actual)
      end)
    end)

    describe("every()", function()
      local predicate

      before_each(function()
        predicate = spy.new(function(value) return value > 10 end)
      end)

      it("should return true when the given array is empty", function()
        local actual = pipe({}, A.every(predicate))
        assert.is_true(actual)
        assert.spy(predicate).was.not_called()
      end)

      it("should return true when all values satisfies the predicate", function()
        local actual = pipe({ 11, 12, 13, 14 }, A.every(predicate))
        assert.is_true(actual)
        assert.spy(predicate).was.called(4)
      end)

      it("should return false when a value does not satisfy the predicate", function()
        local actual = pipe({ 0, 12, 13, 14 }, A.every(predicate))
        assert.is_false(actual)
        assert.spy(predicate).was.called(1)
      end)
    end)

    describe("flatMap()", function()
      it("should", function()
        local function duplicate(value) return { value, value } end
        local actual = pipe({ 1, 2, 3 }, A.flatMap(duplicate))
        assert.are.same({ 1, 1, 2, 2, 3, 3 }, actual)
      end)
    end)

    describe("takeLeft()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should keep only the 2 first elements", function()
        local actual = pipe(array, A.takeLeft(2))
        assert.are.same({ 1, 2 }, actual)
      end)

      it("should return a copy of the initial array when `num` > #array", function()
        local actual = pipe(array, A.takeLeft(7))
        assert.are.same(array, actual)
      end)

      it("should return an empty array when `num` is zero", function()
        local actual = pipe(array, A.takeLeft(0))
        assert.are.same({}, actual)
      end)

      it("should return a copy of the initial array when `num` is negative", function()
        local actual = pipe(array, A.takeLeft(-1))
        assert.are.same(array, actual)
      end)
    end)

    describe("takeRight()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should keep only the 2 first elements", function()
        local actual = pipe(array, A.takeRight(2))
        assert.are.same({ 4, 5 }, actual)
      end)

      it("should return a copy of the initial array when `num` > #array", function()
        local actual = pipe(array, A.takeRight(7))
        assert.are.same(array, actual)
      end)

      it("should return an empty array when `num` is zero", function()
        local actual = pipe(array, A.takeRight(0))
        assert.are.same({}, actual)
      end)

      it("should return a copy of the initial array when `num` is negative", function()
        local actual = pipe(array, A.takeRight(-1))
        assert.are.same(array, actual)
      end)
    end)
  end)

  describe("utils", function()
    describe("is_out_of_bound()", function()
      local array
      before_each(function()
        array = { 1, 2 }
      end)

      it("should return false when the index is valid", function()
        assert.is_false(A.is_out_of_bound(1, array))
        assert.is_false(A.is_out_of_bound(2, array))
      end)

      it("should return true when the index is lower than 1", function()
        local actual = A.is_out_of_bound(0, array)
        assert.is_true(actual)
      end)

      it("should return true when the index is greater than the lenght of the array", function()
        local actual = A.is_out_of_bound(3, array)
        assert.is_true(actual)
      end)
    end)

    describe("flatten()", function()
      it("should return an array of 1 dimension", function()
        local actual = A.flatten({ 1, { 2 }, { 3 } })
        assert.are.same({ 1, 2, 3 }, actual)
      end)

      it("should only flatten the first level of nested arrays", function()
        local actual = A.flatten({ 1, { 2, { 3 } } })
        assert.are.same({ 1, 2, { 3 } }, actual)
      end)
    end)

    describe("head()", function()
      it("should return a None when the array is empty", function()
        assert.are.same(O.none, A.head({}))
      end)

      it("should return the first element of the array wrapped by an Some", function()
        assert.are.same(O.some(1), A.head({ 1 }))
        assert.are.same(O.some(1), A.head({ 1, 2 }))
        assert.are.same(O.some(1), A.head({ 1, 2, 3 }))
      end)
    end)

    describe("last()", function()
      it("should return a None when the array is empty", function()
        assert.are.same(O.none, A.last({}))
      end)

      it("should return the last element of the array wrapped by an Some", function()
        assert.are.same(O.some(1), A.last({ 1 }))
        assert.are.same(O.some(2), A.last({ 1, 2 }))
        assert.are.same(O.some(3), A.last({ 1, 2, 3 }))
      end)
    end)

    describe("size()", function()
      it("should return 0 when the given array is empty", function()
        local actual = A.size({})
        assert.are.equals(0, actual)
      end)

      it("should return 1", function()
        local actual = A.size({ 1 })
        assert.are.equals(1, actual)
      end)

      it("should return 2", function()
        local actual = A.size({ 1, 2 })
        assert.are.equals(2, actual)
      end)
    end)
  end)
end)
