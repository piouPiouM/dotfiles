local fun = require("fun")
local pkind = require("ppm.plugin.cmp.kind")

local M = {
  filters = {}
}

local function character_before_cursor(context)
  local line = context.cursor_line
  local col = context.cursor.col - 1

  return string.sub(line, col, col)
end

local function character_is_member_expression()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor();

  return node ~= nil and (
      node:type() == "dot_index_expression"       -- lua
      or node:type() == "method_index_expression" -- lua
      or node:type() == "member_expression"       -- typescript
      )
end

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

M.all = function(...)
  local predicates = fun.iter(...):filter(function(func) return type(func) == "function" end)
  return function(entry, context)
    return predicates:all(function(fn) return fn(entry, context) end)
  end
end


M.some = function(...)
  local predicates = fun.iter(...):filter(function(func) return type(func) == "function" end)
  return function(entry, context)
    return predicates:some(function(fn) return fn(entry, context) end)
  end
end

return M
