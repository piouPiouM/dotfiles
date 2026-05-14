local spy = require("luassert.spy")
local O = require("ppm.toolkit.fp.Option")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

describe("Array", function()
  local Module = require("ppm.toolkit.fp.Array")

  describe("constructors", function()
    describe("of()", function()
      it("should return an array with the given value", function()
        local actual = Module.of(1)
        assert.are.same({ 1 }, actual)
        assert.are.equals(1, actual[1])
      end)

      it("should return an array with the given nil", function()
        local actual = Module.of(nil)
        assert.are.same({ nil }, actual)
        assert.are.equals(nil, actual[1])
      end)
    end)
  end)

  describe("refiners", function()
    describe("is_empty()", function()
      it("should return true when the given array is empty", function()
        local actual = Module.is_empty({})
        assert.is_true(actual)
      end)

      it("should return false when the given array contains entries", function()
        local actual = Module.is_empty({ 1 })
        assert.is_false(actual)
      end)
    end)
  end)

  describe("converters", function()
    describe("from_option()", function()
      it("should return an empty array when the given Option is a None", function()
        local actual = Module.from_option(O.none)
        assert.are.same({}, actual)
      end)

      it("should return an array with the content of the given Some", function()
        local actual = Module.from_option(O.some(0))
        assert.are.same({ 0 }, actual)
      end)
    end)
  end)

  describe("pipeables", function()
    describe("concat()", function()
      it("should return a copy of the second array when the first is empty", function()
        local second = { 2 }
        local actual = pipe({}, Module.concat(second))
        assert.are.same({ 2 }, actual)
        assert.are.not_equals(second, actual)
      end)

      it("should return a copy of the first array when the second is empty", function()
        local first = { 1 }
        local actual = pipe({}, Module.concat(first))
        assert.are.same({ 1 }, actual)
        assert.are.not_equals(first, actual)
      end)

      it("should return an array with the values of the two given arrays", function()
        local actual = pipe({ 1 }, Module.concat({ 2 }))
        assert.are.same({ 1, 2 }, actual)
      end)

      it("should return an array with mixed types", function()
        local actual = pipe({ 1 }, Module.concat({ "a" }))
        assert.are.same({ 1, "a" }, actual)
      end)
    end)

    describe("every()", function()
      local predicate

      before_each(function()
        predicate = spy.new(function(value) return value > 10 end)
      end)

      it("should return true when the given array is empty", function()
        local actual = pipe({}, Module.every(predicate))
        assert.is_true(actual)
        assert.spy(predicate).was.not_called()
      end)

      it("should return true when all values satisfies the predicate", function()
        local actual = pipe({ 11, 12, 13, 14 }, Module.every(predicate))
        assert.is_true(actual)
        assert.spy(predicate).was.called(4)
      end)

      it("should return false when a value does not satisfy the predicate", function()
        local actual = pipe({ 0, 12, 13, 14 }, Module.every(predicate))
        assert.is_false(actual)
        assert.spy(predicate).was.called(1)
      end)
    end)

    describe("flatmap()", function()
      it("should", function()
        local function duplicate(value) return { value, value } end
        local actual = pipe({ 1, 2, 3 }, Module.flatmap(duplicate))
        assert.are.same({ 1, 1, 2, 2, 3, 3 }, actual)
      end)
    end)

    describe("sort()", function()
      it("should sort the array by string in ascending order", function()
        local S = require("ppm.toolkit.fp.string")
        local actual = pipe(
          { "b", "c", "a" },
          Module.sort(S.Ord)
        )
        assert.are.same({ "a", "b", "c" }, actual)
      end)

      it("should sort the array by number in ascending order", function()
        local N = require("ppm.toolkit.fp.number")
        local actual = pipe(
          { 2, 3, 1 },
          Module.sort(N.Ord)
        )
        assert.are.same({ 1, 2, 3 }, actual)
      end)
    end)

    describe("take_left()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should keep only the 2 first elements", function()
        local actual = pipe(array, Module.take_left(2))
        assert.are.same({ 1, 2 }, actual)
      end)

      it("should return a copy of the initial array when `num` > #array", function()
        local actual = pipe(array, Module.take_left(7))
        assert.are.same(array, actual)
      end)

      it("should return an empty array when `num` is zero", function()
        local actual = pipe(array, Module.take_left(0))
        assert.are.same({}, actual)
      end)

      it("should return a copy of the initial array when `num` is negative", function()
        local actual = pipe(array, Module.take_left(-1))
        assert.are.same(array, actual)
      end)
    end)

    describe("take_right()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should keep only the 2 first elements", function()
        local actual = pipe(array, Module.take_right(2))
        assert.are.same({ 4, 5 }, actual)
      end)

      it("should return a copy of the initial array when `num` > #array", function()
        local actual = pipe(array, Module.take_right(7))
        assert.are.same(array, actual)
      end)

      it("should return an empty array when `num` is zero", function()
        local actual = pipe(array, Module.take_right(0))
        assert.are.same({}, actual)
      end)

      it("should return a copy of the initial array when `num` is negative", function()
        local actual = pipe(array, Module.take_right(-1))
        assert.are.same(array, actual)
      end)
    end)

    describe("append()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should insert the value to the end of the array", function()
        local actual = pipe(array, Module.append(6))
        assert.are.same({ 1, 2, 3, 4, 5, 6 }, actual)
      end)

      it("should not mutate the original array", function()
        local actual = pipe(array, Module.append(6))
        assert.are.not_same(array, actual)
        assert.are.same({ 1, 2, 3, 4, 5 }, array)
      end)
    end)

    describe("prepend()", function()
      local array
      before_each(function()
        array = { 1, 2, 3, 4, 5 }
      end)

      it("should insert the value to the begining of the array", function()
        local actual = pipe(array, Module.prepend(0))
        assert.are.same({ 0, 1, 2, 3, 4, 5 }, actual)
      end)

      it("should not mutate the original array", function()
        local actual = pipe(array, Module.prepend(6))
        assert.are.not_same(array, actual)
        assert.are.same({ 1, 2, 3, 4, 5 }, array)
      end)
    end)

    describe("filter()", function()
      it("should filter entries by index, return a new array with only evens", function()
        local actual = pipe(
          { "a", "b", "c", "d" },
          Module.filter(function(_, key) return key % 2 == 0 end)
        )
        assert.are.same({ "b", "d" }, actual)
      end)

      it("should filter entries by values, return a new array with 'a' and 'b'", function()
        local actual = pipe(
          { "a", "b", "c", "d" },
          Module.filter(function(value) return value == "a" or value == "b" end)
        )
        assert.are.same({ "a", "b" }, actual)
      end)

      it("should return a new array", function()
        local arr = { 1, 2 }
        local actual = pipe(arr, Module.filter(F.constTrue()))
        assert.are.same(arr, actual)
        assert.are.not_equals(tostring(arr), tostring(actual))
      end)
    end)

    describe("filter_map()", function()
      it("should return an empty array when it receive an empty array", function()
        local actual = pipe({}, Module.filter_map(F.identity))
        assert.are.same({}, actual)
      end)

      describe("by value", function()
        local function is_even(n) return n % 2 == 0 and O.some(n) or O.none end

        it("should return an array of evens", function()
          local actual = pipe({ 1, 2, 3, 4, 5 }, Module.filter_map(is_even))
          assert.are.same({ 2, 4 }, actual)
        end)

        it("should return an empty array when no value is even", function()
          local actual = pipe({ 1, 3, 5 }, Module.filter_map(is_even))
          assert.are.same({}, actual)
        end)
      end)

      describe("by index", function()
        local function is_even(_, n) return n % 2 == 0 and O.some(n) or O.none end

        it("should return an array of even indexes", function()
          local actual = pipe({ 1, 2, 3, 4, 5 }, Module.filter_map(is_even))
          assert.are.same({ 2, 4 }, actual)
        end)

        it("should return an empty array when no index is even", function()
          local actual = pipe({ 1 }, Module.filter_map(is_even))
          assert.are.same({}, actual)
        end)
      end)
    end)

    describe("compact()", function()
      it("should remove the None from the given array", function()
        local actual = pipe(
          { O.none, O.some("a"), O.none, O.none, O.some("b"), O.none },
          Module.compact
        )
        assert.are.same({ "a", "b" }, actual)
      end)

      it("should return a new array", function()
        local arr = { O.some("a"), O.some("b") }
        local actual = pipe(arr, Module.compact)
        assert.are.not_equals(tostring(arr), tostring(actual))
      end)

      it("should return an empty array", function()
        local actual = pipe(
          { O.none, O.none, O.none, O.none },
          Module.compact
        )
        assert.are.same({}, actual)
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
        assert.is_false(Module.is_out_of_bound(1, array))
        assert.is_false(Module.is_out_of_bound(2, array))
      end)

      it("should return true when the index is lower than 1", function()
        local actual = Module.is_out_of_bound(0, array)
        assert.is_true(actual)
      end)

      it("should return true when the index is greater than the lenght of the array", function()
        local actual = Module.is_out_of_bound(3, array)
        assert.is_true(actual)
      end)
    end)

    describe("flatten()", function()
      it("should return an array of 1 dimension", function()
        local actual = Module.flatten({ 1, { 2 }, { 3 } })
        assert.are.same({ 1, 2, 3 }, actual)
      end)

      it("should only flatten the first level of nested arrays", function()
        local actual = Module.flatten({ 1, { 2, { 3 } } })
        assert.are.same({ 1, 2, { 3 } }, actual)
      end)
    end)

    describe("head()", function()
      it("should return a None when the array is empty", function()
        assert.are.same(O.none, Module.head({}))
      end)

      it("should return the first element of the array wrapped by an Some", function()
        assert.are.same(O.some(1), Module.head({ 1 }))
        assert.are.same(O.some(1), Module.head({ 1, 2 }))
        assert.are.same(O.some(1), Module.head({ 1, 2, 3 }))
      end)
    end)

    describe("last()", function()
      it("should return a None when the array is empty", function()
        assert.are.same(O.none, Module.last({}))
      end)

      it("should return the last element of the array wrapped by an Some", function()
        assert.are.same(O.some(1), Module.last({ 1 }))
        assert.are.same(O.some(2), Module.last({ 1, 2 }))
        assert.are.same(O.some(3), Module.last({ 1, 2, 3 }))
      end)
    end)

    describe("size()", function()
      it("should return 0 when the given array is empty", function()
        local actual = Module.size({})
        assert.are.equals(0, actual)
      end)

      it("should return 1", function()
        local actual = Module.size({ 1 })
        assert.are.equals(1, actual)
      end)

      it("should return 2", function()
        local actual = Module.size({ 1, 2 })
        assert.are.equals(2, actual)
      end)
    end)
  end)
end)
