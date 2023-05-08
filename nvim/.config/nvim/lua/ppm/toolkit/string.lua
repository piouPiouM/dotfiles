local M = {}

--- Checks if string starts with the given target string.
--- @param string string The string to search for.
--- @param target string The string to inspect
--- @return boolean
function M.startsWith(string, target)
  return target:find(string, 1, true) == 1
end

return M
