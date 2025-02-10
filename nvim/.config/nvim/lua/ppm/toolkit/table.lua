local M = {}

--- Find the index of a value in a table.
---
--- @param tbl table The table to search in.
--- @param value any The value to search for.
--- @return number The index of the value if found, `-1` otherwise.
M.find_index = function(tbl, value)
  local indices = vim.tbl_filter(function(v)
    return v == value
  end, tbl)

  return indices[1] or -1
end

return M
