local async = require("plenary.async").tests
local F = require("ppm.toolkit.fp.function")
local E = require("ppm.toolkit.fp.Either")

describe("Frontmatter", function()
  local Module = require("ppm.toolkit.frontmatter")

  describe("parse()", function()
    it("should parse empty frontmatter", function()
      local content = [[
---
---
Content here
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {},
        content = "Content here"
      }, E.toNullable(result))
    end)

    it("should parse basic key-value pairs", function()
      local content = [[
---
title: Hello World
author: John Doe
---
Content here
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {
          title = "Hello World",
          author = "John Doe"
        },
        content = "Content here"
      }, E.toNullable(result))
    end)

    it("should parse lists", function()
      local content = [[
---
tags:
- javascript
- programming
categories:
- tutorial
---
Content here
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {
          tags = { "javascript", "programming" },
          categories = { "tutorial" }
        },
        content = "Content here"
      }, E.toNullable(result))
    end)

    it("should parse mixed types", function()
      local content = [[
---
title: Hello World
published: true
views: 42
tags:
- javascript
- lua
empty_array: []
empty_object: {}
---
Content here
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {
          title = "Hello World",
          published = true,
          views = 42,
          tags = { "javascript", "lua" },
          empty_array = {},
          empty_object = {}
        },
        content = "Content here"
      }, E.toNullable(result))
    end)

    it("should handle missing frontmatter delimiters", function()
      local content = "Just content without frontmatter"
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {},
        content = "Just content without frontmatter",
      }, E.toNullable(result))
    end)

    it("should handle malformed frontmatter", function()
      local content = [[
---
invalid-line-without-value
---
Content
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {},
        content = "Content"
      }, E.toNullable(result))
    end)

    it("should handle list items without key", function()
      local content = [[
---
- item1
- item2
---
Content
]]
      local result = Module.parse(content)
      assert.is_true(E.is_left(result))
      assert.are.equals("List item without a key.", E.getOrElse(F.identity)(result))
    end)

    it("should preserve content indentation", function()
      local content = [[
---
title: Test
---
  Indented line
    More indented
Normal line
]]
      local result = Module.parse(content)
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = { title = "Test" },
        content = "  Indented line\n    More indented\nNormal line"
      }, E.toNullable(result))
    end)

    describe("whitespace handling", function()
      it("should handle extra whitespace around frontmatter delimiters", function()
        local content = [[

---
title: Test
---

Content
]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = { title = "Test" },
          content = "Content"
        }, E.toNullable(result))
      end)

      it("should handle multiple empty lines between frontmatter and content", function()
        local content = [[
---
title: Test
---


Content
]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = { title = "Test" },
          content = "Content"
        }, E.toNullable(result))
      end)

      it("should handle no space between frontmatter and content", function()
        local content = [[
---
title: Test
---
Content]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = { title = "Test" },
          content = "Content"
        }, E.toNullable(result))
      end)

      it("should preserve indentation in list items", function()
        local content = [[
---
tags:
  - item1
    - item2
 - item3
---
Content]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = {
            tags = { "item1", "item2", "item3" }
          },
          content = "Content"
        }, E.toNullable(result))
      end)

      it("should handle mixed spaces and tabs in frontmatter", function()
        local content = [[
---
title:	Test
description:  Multiple spaces
key:		Tab separated
---
Content]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = {
            title = "Test",
            description = "Multiple spaces",
            key = "Tab separated"
          },
          content = "Content"
        }, E.toNullable(result))
      end)

      it("should handle empty lines in frontmatter", function()
        local content = [[
---
title: Test

tags:
- item1

- item2

description: With empty lines
---
Content]]
        local result = Module.parse(content)
        assert.is_true(E.is_right(result))
        assert.are.same({
          frontmatter = {
            title = "Test",
            tags = { "item1", "item2" },
            description = "With empty lines"
          },
          content = "Content"
        }, E.toNullable(result))
      end)
    end)
  end)

  async.describe("parse_file()", function()
    local stubs_path = string.format("%s/lua/tests/stubs/", vim.fn.expand("<sfile>:p:h"))

    async.it("should parse an empty frontmatter", function()
      local result = Module.parse_file(stubs_path .. "frontmatter/no_frontmatter.md")
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {},
        content = [[Lorem ipsum
dolor sit amet,
consectetur adipisicing elit.]]
      }, E.toNullable(result))
    end)

    async.it("should parse a file with frontmatter", function()
      local result = Module.parse_file(stubs_path .. "frontmatter/basic.md")
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {
          title = "Hello, World!",
        },
        content = [[Lorem ipsum
dolor sit amet,
consectetur adipisicing elit.]]
      }, E.toNullable(result))
    end)

    async.it("should parse frontmatter with list", function()
      local result = Module.parse_file(stubs_path .. "frontmatter/with_lists.md")
      assert.is_true(E.is_right(result))
      assert.are.same({
        frontmatter = {
          title = "Hello, World!",
          colors = { "rebeccapurple", "deeppink" },
          tags = { "computer", "science" },
        },
        content = [[Lorem ipsum
dolor sit amet,
consectetur adipisicing elit.]]
      }, E.toNullable(result))
    end)
  end)
end)
