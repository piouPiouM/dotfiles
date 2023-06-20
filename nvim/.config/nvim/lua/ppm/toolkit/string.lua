local M = {}

--- Checks if string starts with the given target string.
--- @param str string The string to search for.
--- @param target string The string to inspect
--- @return boolean
function M.startsWith(str, target)
  return target:find(str, 1, true) == 1
end

function M.words(str)
  return vim.fn.split(str)
end

return M
