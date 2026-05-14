local spy = require("luassert.spy")
local A = require("ppm.toolkit.fp.Array")
local B = require("ppm.toolkit.fp.boolean")
local N = require("ppm.toolkit.fp.number")
local S = require("ppm.toolkit.fp.string")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

local LOWER = -1
local EQUALS = 0
local GREATER = 1

describe("Ord", function()
  local Module = require("ppm.toolkit.fp.Ord")

  describe("constructors", function()
    describe("from_compare()", function()
      local arr1, arr2, callback, comparator

      before_each(function()
        arr1 = { 1 }
        arr2 = { 2 }
        callback = spy.new(function(x, y)
          return N.Ord.compare(x[1], y[1])
        end)
        comparator = Module.from_compare(callback)
      end)

      describe("\b.equals()", function()
        it("should return true when the two numbers are equals", function()
          local numberCompare = Module.from_compare(N.Ord.compare)
          assert.is_true(numberCompare.equals(0, 0))
          assert.is_true(numberCompare.equals(1, 1))
        end)

        it("should return false when the two numbers are differents", function()
          local numberCompare = Module.from_compare(N.Ord.compare)
          assert.is_false(numberCompare.equals(0, 1))
          assert.is_false(numberCompare.equals(1, 0))
        end)

        it("should not calls the given function when arguments are the sames", function()
          assert.is_true(comparator.equals(arr1, arr1))
          assert.spy(callback).called(0)
        end)
      end)

      describe("\b.compare()", function()
        it("should not calls the given function when arguments are the sames", function()
          assert.are.equals(EQUALS, comparator.compare(arr1, arr1))
          assert.spy(callback).called(0)
        end)

        it("should return -1 when first < second", function()
          assert.are.equals(LOWER, comparator.compare(arr1, arr2))
          assert.spy(callback).called(1)
        end)

        it("should return 1 when first > second", function()
          assert.are.equals(GREATER, comparator.compare(arr2, arr1))
          assert.spy(callback).called(1)
        end)
      end)
    end)
  end)

  describe("combinators", function()
    describe("reverse()", function()
      it("should return 0 when first == second", function()
        local comparator = Module.reverse(N.Ord)
        assert.are.equals(EQUALS, comparator.compare(0, 0))
      end)

      it("should return 1 when first < second", function()
        local comparator = Module.reverse(N.Ord)
        assert.are.equals(GREATER, comparator.compare(0, 1))
      end)

      it("should return -1 when first > second", function()
        local comparator = Module.reverse(N.Ord)
        assert.are.equals(LOWER, comparator.compare(1, 0))
      end)
    end)

    describe("tuple()", function()
      it("should return 0 when the two arrays are the sames", function()
        local instance = Module.tuple(S.Ord, N.Ord, B.Ord)
        local arr1 = { "a", 1, true }
        assert.are.equals(0, instance.compare(arr1, arr1))
      end)

      it("should return the result of a comparison as soon as it is different from 0", function()
        local instance = Module.tuple(S.Ord, N.Ord, B.Ord)
        local arr1 = { "a", 1, true }
        assert.are.equals(-1, instance.compare(arr1, { "b", 1, true }))
        assert.are.equals(-1, instance.compare(arr1, { "a", 2, true }))
        assert.are.equals(1, instance.compare(arr1, { "a", 1, false }))
      end)
    end)
  end)

  describe("instances", function()
    describe("get_monoid()", function()
      it("FIXME", function()
        local M = require("ppm.toolkit.fp.Monoid")
        local tuples = {
          { 2, "c" },
          { 1, "b" },
          { 2, "a" },
          { 1, "c" }
        }
        local monoid = Module.get_monoid()
        local sort_by_first = pipe(
          N.Ord,
          Module.contramap(function(tuple) return tuple[1] end)
        )
        local sort_by_second = pipe(
          S.Ord,
          Module.contramap(function(tuple) return tuple[2] end)
        )

        local ord_1 = M.concat_all(monoid)({ sort_by_first, sort_by_second })
        assert.are.same({
          { 1, "b" },
          { 1, "c" },
          { 2, "a" },
          { 2, "c" },
        }, pipe(tuples, A.sort(ord_1)))

        local ord_2 = M.concat_all(monoid)({ sort_by_second, sort_by_first })
        assert.are.same({
          { 2, "a" },
          { 1, "b" },
          { 1, "c" },
          { 2, "c" },
        }, pipe(tuples, A.sort(ord_2)))
      end)
    end)
  end)

  describe("pipeables", function()
    describe("between()", function()
      local betweenNumbers

      before_each(function()
        betweenNumbers = Module.between(N.Ord)
      end)

      it("should return true when the given number is between the two boundaries", function()
        assert.is_true(pipe(2, betweenNumbers(1, 10)))
      end)

      it("should return true when the given number is equals to the lower boundary", function()
        assert.is_true(pipe(1, betweenNumbers(1, 10)))
      end)

      it("should return true when the given number is equals to the upper boundary", function()
        assert.is_true(pipe(10, betweenNumbers(1, 10)))
      end)

      it("should return true when the given number and boundaries are equals", function()
        assert.is_true(pipe(1, betweenNumbers(1, 1)))
      end)

      it("should return false when the given number is outside the two boundaries", function()
        assert.is_false(pipe(0, betweenNumbers(1, 10)))
        assert.is_false(pipe(11, betweenNumbers(1, 10)))
      end)
    end)

    describe("clamp()", function()
      it("should return the same number", function()
        local clampNumber = Module.clamp(N.Ord)
        assert.are.equals(2, pipe(2, clampNumber(1, 10)))
      end)

      it("should return the minimum when the value is lower", function()
        local clampNumber = Module.clamp(N.Ord)
        assert.are.equals(1, pipe(0, clampNumber(1, 10)))
      end)

      it("should return the maximum when the value is greater", function()
        local clampNumber = Module.clamp(N.Ord)
        assert.are.equals(10, pipe(11, clampNumber(1, 10)))
      end)
    end)

    describe("contramap()", function()
      it("should order by the second entry", function()
        local arr1 = { "a", "d" }
        local arr2 = { "b", "c" }
        local sort_by_idx_2 = pipe(
          S.Ord,
          Module.contramap(function(arr) return arr[2] end)
        )
        assert.are.same(
          { arr2, arr1 },
          pipe({ arr1, arr2 }, A.sort(sort_by_idx_2))
        )
      end)
    end)
  end)

  describe("utils", function()
    describe("equals()", function()
      it("should return true when the Ord resolve an equality between the two arguments", function()
        local are_equals = Module.equals(N.Ord)
        assert.is_true(are_equals(-1, -1))
        assert.is_true(are_equals(0, 0))
        assert.is_true(are_equals(1, 1))
      end)
    end)

    describe("gt()", function()
      it("should return true when the first argument is greater than the second", function()
        local is_greater_number = Module.gt(N.Ord)
        assert.is_true(is_greater_number(0, -1))
        assert.is_true(is_greater_number(1, 0))
        assert.is_true(is_greater_number(2, 1))
      end)

      it("should return false when the first argument is lower than the second", function()
        local is_greater_number = Module.gt(N.Ord)
        assert.is_false(is_greater_number(-1, 0))
        assert.is_false(is_greater_number(0, 1))
        assert.is_false(is_greater_number(1, 2))
      end)

      it("should return false when the two arguments are equals", function()
        local is_greater_number = Module.gt(N.Ord)
        assert.is_false(is_greater_number(-1, -1))
        assert.is_false(is_greater_number(0, 0))
        assert.is_false(is_greater_number(1, 1))
      end)
    end)

    describe("gte()", function()
      it("should return true when the first argument is greater than the second", function()
        local is_greater_number = Module.gte(N.Ord)
        assert.is_true(is_greater_number(0, -1))
        assert.is_true(is_greater_number(1, 0))
        assert.is_true(is_greater_number(2, 1))
      end)

      it("should return false when the first argument is lower than the second", function()
        local is_greater_number = Module.gte(N.Ord)
        assert.is_false(is_greater_number(-1, 0))
        assert.is_false(is_greater_number(0, 1))
        assert.is_false(is_greater_number(1, 2))
      end)

      it("should return true when the two arguments are equals", function()
        local is_greater_number = Module.gte(N.Ord)
        assert.is_true(is_greater_number(-1, -1))
        assert.is_true(is_greater_number(0, 0))
        assert.is_true(is_greater_number(1, 1))
      end)
    end)

    describe("lt()", function()
      it("should return true when the first argument is lower than the second", function()
        local is_lower_number = Module.lt(N.Ord)
        assert.is_true(is_lower_number(-1, 0))
        assert.is_true(is_lower_number(0, 1))
        assert.is_true(is_lower_number(1, 2))
      end)

      it("should return false when the first argument is greater than the second", function()
        local is_lower_number = Module.lt(N.Ord)
        assert.is_false(is_lower_number(0, -1))
        assert.is_false(is_lower_number(1, 0))
        assert.is_false(is_lower_number(2, 1))
      end)

      it("should return false when the two arguments are equals", function()
        local is_lower_number = Module.lt(N.Ord)
        assert.is_false(is_lower_number(-1, -1))
        assert.is_false(is_lower_number(0, 0))
        assert.is_false(is_lower_number(1, 1))
      end)
    end)

    describe("lte()", function()
      it("should return true when the first argument is lower than the second", function()
        local is_lower_number = Module.lte(N.Ord)
        assert.is_true(is_lower_number(-1, 0))
        assert.is_true(is_lower_number(0, 1))
        assert.is_true(is_lower_number(1, 2))
      end)

      it("should return false when the first argument is greater than the second", function()
        local is_lower_number = Module.lte(N.Ord)
        assert.is_false(is_lower_number(0, -1))
        assert.is_false(is_lower_number(1, 0))
        assert.is_false(is_lower_number(2, 1))
      end)

      it("should return true when the two arguments are equals", function()
        local is_lower_number = Module.lte(N.Ord)
        assert.is_true(is_lower_number(-1, -1))
        assert.is_true(is_lower_number(0, 0))
        assert.is_true(is_lower_number(1, 1))
      end)
    end)

    describe("max()", function()
      it("should return the maximum of the two numbers", function()
        local max = Module.max(N.Ord)
        assert.are.equals(1, max(0, 1))
        assert.are.equals(1, max(1, 0))
      end)

      it("should return the table with the maximum property", function()
        local lowest = { a = 1 }
        local greatest = { a = 2 }
        local max = Module.max(pipe(
          N.Ord,
          Module.contramap(function(t) return t.a end)
        ))
        assert.are.same({ a = 2 }, max(lowest, greatest))
        assert.are.same({ a = 2 }, max(greatest, lowest))
        assert.are.equals(greatest, max(lowest, greatest))
      end)
    end)

    describe("min()", function()
      it("should return the minimum of the two numbers", function()
        local min = Module.min(N.Ord)
        assert.are.equals(0, min(0, 1))
        assert.are.equals(0, min(1, 0))
      end)

      it("should return the table with the minimum property", function()
        local lowest = { a = 1 }
        local greatest = { a = 2 }
        local min = Module.min(pipe(
          N.Ord,
          Module.contramap(function(t) return t.a end)
        ))
        assert.are.same({ a = 1 }, min(lowest, greatest))
        assert.are.same({ a = 1 }, min(greatest, lowest))
        assert.are.equals(lowest, min(lowest, greatest))
      end)
    end)
  end)
end)
