local spy = require("luassert.spy")

describe("Color/Parser", function()
  local Module = require("ppm.toolkit.color.parser")

  local function always_table()
    return {}
  end

  local function always_true()
    return true
  end

  local function always_false()
    return false
  end

  describe("constructor", function()
    describe("of()", function()
      it("should create a Parser", function()
        local parser = Module:of(always_true)
        local actual = parser.tag

        assert.are.equals("color.parser", actual)
      end)
    end)
  end)

  describe("metamethods", function()
    describe("__len()", function()
      it("should return zero", function()
        local parser = Module:of(always_true)
        local actual = #parser

        assert.are.equals(0, actual)
      end)
      it("should return 1 pattern", function()
        local parser = Module:of(always_true)
        local actual = #parser:add("%a")

        assert.are.equals(1, actual)
      end)

      it("should return 2 patterns", function()
        local parser = Module:of(always_true)
        local actual = #parser:add("%a"):add("%d")

        assert.are.equals(2, actual)
      end)
    end)
  end)

  describe("refiners", function()
    describe("valid()", function()

    end)
  end)

  describe("FIXME", function()
    describe("add()", function()
      it("should add 1 pattern", function()
        local parser = Module:of(always_true):add("%a")
        local actual = parser[1]

        assert.are.equals("%a", actual)
      end)

      it("should be replaced by regular `table.insert`", function()
        local parser = Module:of(always_true)
        table.insert(parser, "%a")
        local actual = parser[1]

        assert.are.equals("%a", actual)
      end)
    end)

    describe("all()", function()
      it("should return all patterns with captures", function()
        local parser = Module:of(always_true)
            :add("(%a)")
            :add("(%a) (%d)")
        local actual = parser:all()

        assert.are.same({ "(%a)", "(%a) (%d)" }, actual)
      end)

      it("should return all patterns with captures removed", function()
        local parser = Module:of(always_true)
            :add("(%a)")
            :add("(%a) (%d)")
        local actual = parser:all({ with_captures = false })

        assert.are.same({ "%a", "%a %d" }, actual)
      end)
    end)

    describe("parse()", function()
      it("FIXME", function()
        local parser = Module:of(always_true)
            :add("(%d) (%d) (%d)")
            :add("(%d) (%d)")
            :match(function(match)
              local a, b, c = unpack(match)

              return { a = tonumber(a) or 0, b = tonumber(b) or 0, c = tonumber(c) or 0 }
            end)
        local actual = parser:parse("1 2")

        assert.are.same({ a = 1, b = 2, c = 0 }, actual)
      end)
    end)
  end)
end)
