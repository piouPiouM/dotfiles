local pkind = require("ppm.plugin.cmp.kind")
local F = require("ppm.toolkit.fp.function")
local A = require("ppm.toolkit.fp.Array")
local O = require("ppm.toolkit.fp.Option")
local pipe = F.pipe

local M = {
  filters = {},
  fp = {}
}


M.fp.character_is_member_expression = function()
  local node = require("nvim-treesitter.ts_utils").get_node_at_cursor();
  local member_expression_types = {
    "dot_index_expression",    -- lua
    "method_index_expression", -- lua
    "member_expression",       -- typescript
  }

  return pipe(
    O.of(node),
    O.flatMap(function(n) return n:type() end),
    O.getOrElse(F.constFalse)
  );

  -- return node ~= nil and (
  --     node:type() == "dot_index_expression"       -- lua
  --     or node:type() == "method_index_expression" -- lua
  --     or node:type() == "member_expression"       -- typescript
  --     )
end

local function character_before_cursor(context)
  local line = context.cursor_line
  local col = context.cursor.col - 1

  return string.sub(line, col, col)
end

local function character_is_member_expression()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor();

  return node ~= nil and (
    node:type() == "dot_index_expression"         -- lua
    or node:type() == "method_index_expression"   -- lua
    or node:type() == "member_expression"         -- typescript
  )
end

--- Keeps only the members of the current expression.
---
---@param entry cmp.Entry
---@param context cmp.Context
---@return boolean
M.filters.keepMembersOnly = function(entry, context)
  local kind = entry:get_kind()
  local current_char = character_before_cursor(context)

  if character_is_member_expression()
      or current_char == "."
      or current_char == ":" then
    return pkind.is("Function", kind)
        or pkind.is("Method", kind)
        or pkind.is("Field", kind)
        or pkind.is("Property", kind)
  end

  return true
end

-- M.all = function(...)
--   local predicates = fun.iter(...):filter(function(func) return type(func) == "function" end)
--   return function(entry, context)
--     return predicates:all(function(fn) return fn(entry, context) end)
--   end
-- end
--
--
-- M.some = function(...)
--   local predicates = fun.iter(...):filter(function(func) return type(func) == "function" end)
--   return function(entry, context)
--     return predicates:some(function(fn) return fn(entry, context) end)
--   end
-- end

return M
