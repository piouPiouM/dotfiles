local F = require("ppm.toolkit.fp.function")
local E = require("ppm.toolkit.fp.Either")
local O = require("ppm.toolkit.fp.Option")

describe("Frontmatter Utils", function()
  local Module = require("ppm.toolkit.frontmatter.utils")

  describe("parse_value()", function()
    it("should handle empty arrays", function()
      assert.are.same({}, Module.parse_value("[]"))
      assert.are.same({}, Module.parse_value("[ ]"))
    end)

    it("should handle empty objects", function()
      assert.are.same({}, Module.parse_value("{}"))
      assert.are.same({}, Module.parse_value("{ }"))
    end)

    it("should handle numbers", function()
      assert.are.equals(42, Module.parse_value("42"))
      assert.are.equals(-3.14, Module.parse_value("-3.14"))
    end)

    it("should handle booleans", function()
      assert.is_true(Module.parse_value("true"))
      assert.is_false(Module.parse_value("false"))
    end)

    it("should keep strings as-is", function()
      assert.are.equals("hello", Module.parse_value("hello"))
      assert.are.equals("42abc", Module.parse_value("42abc"))
    end)
  end)

  describe("parse_line()", function()
    it("should parse valid key-value pairs", function()
      local result = Module.parse_line("title: Hello World")
      assert.is_true(O.is_some(result))
      assert.are.same({ "title", "Hello World" }, O.toNullable(result))
    end)

    it("should trim whitespaces around key and value", function()
      local result = Module.parse_line("title:    Hello World   ")
      assert.is_true(O.is_some(result))
      assert.are.same({ "title", "Hello World" }, O.toNullable(result))
    end)

    it("should return none for invalid lines", function()
      local result = Module.parse_line("invalid line")
      assert.is_true(O.is_none(result))
    end)
  end)

  describe("parse_list_item()", function()
    it("should parse valid list item", function()
      local result = Module.parse_list_item("- item1")
      assert.is_true(O.is_some(result))
      assert.are.equals("item1", O.toNullable(result))
    end)

    it("should parse valid list items w/o whitespace arround the dash", function()
      local result = Module.parse_list_item("-item1")
      assert.is_true(O.is_some(result))
      assert.are.equals("item1", O.toNullable(result))
    end)

    it("should handle whitespaces", function()
      local result = Module.parse_list_item("  -    item1   ")
      assert.is_true(O.is_some(result))
      assert.are.equals("item1   ", O.toNullable(result))
    end)

    it("should return none for invalid list item", function()
      local result = Module.parse_list_item("invalid item")
      assert.is_true(O.is_none(result))
    end)
  end)

  describe("handle_line_with_value()", function()
    it("should add new key-value pairs", function()
      local result = Module.handle_line_with_value({}, "title", "Hello")
      assert.is_true(E.is_right(result))
      assert.are.same({ title = "Hello" }, E.toNullable(result))
    end)

    it("should override existing keys", function()
      local result = Module.handle_line_with_value({ title = "Old" }, "title", "New")
      assert.is_true(E.is_right(result))
      assert.are.same({ title = "New" }, E.toNullable(result))
    end)
  end)

  describe("handle_list_item()", function()
    it("should create new array for first item", function()
      local result = Module.handle_list_item({}, "tags", "tag1")
      assert.is_true(E.is_right(result))
      assert.are.same({ tags = { "tag1" } }, E.toNullable(result))
    end)

    it("should append to existing array", function()
      local data = { tags = { "tag1" } }
      local result = Module.handle_list_item(data, "tags", "tag2")
      assert.is_true(E.is_right(result))
      assert.are.same({ tags = { "tag1", "tag2" } }, E.toNullable(result))
    end)

    it("should override existing value", function()
      local data = { tags = { "tag1" } }
      local result = Module.handle_list_item(data, "tags", "tag1")
      assert.is_true(E.is_right(result))
      assert.are.same({ tags = { "tag1" } }, E.toNullable(result))
    end)

    it("should return error for invalid list syntax", function()
      local data = { tags = "not-an-array" }
      local result = Module.handle_list_item(data, "tags", "tag2")
      assert.is_true(E.is_left(result))
      assert.are.equals("Invalid list syntax.", E.getOrElse(F.identity)(result))
    end)
  end)

  describe("process_line()", function()
    it("should process key-value lines", function()
      local result = Module.process_line({}, O.none, "title: Hello")
      assert.is_true(E.is_right(result))
      assert.are.same({ title = "Hello" }, E.toNullable(result))
    end)

    it("should process list items with current key", function()
      local result = Module.process_line({}, O.some("tags"), "- tag1")
      assert.is_true(E.is_right(result))
      assert.are.same({ tags = { "tag1" } }, E.match(F.identity, F.identity)(result))
    end)

    it("should return error for list items without key", function()
      local result = Module.process_line({}, O.none, "- tag1")
      assert.is_true(E.is_left(result))
      assert.are.equals("List item without a key.", E.getOrElse(F.identity)(result))
    end)

    it("should ignore empty lines", function()
      local result = Module.process_line({ title = "Hello" }, O.none, "")
      assert.is_true(E.is_right(result))
      assert.are.same({ title = "Hello" }, E.toNullable(result))
    end)
  end)
end)
