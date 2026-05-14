local M = {}

--- Resolves path of the given rule name in user/global land.
---
---@param name string
---@return string|nil
M.get_global_path = function(name)
  local rules_path = string.format(
    "%s/ai/rules/%s.md",
    vim.g.ppm_ai_path,
    name or "global"
  )

  if vim.fn.filereadable(rules_path) == 1 then
    return rules_path
  end

  return nil
end

--- Resolves path of the given rule name in project land.
---
---@param name string
---@return string|nil
M.get_project_path = function(name)
  local path = vim.fn.getcwd()

  while path ~= "/" do
    local rules_path = string.format("%s/.ai/%s.md", path, name or "instructions")

    if vim.fn.filereadable(rules_path) == 1 then
      vim.notify("Found project instructions at " .. rules_path)

      return rules_path
    end

    path = vim.fn.fnamemodify(path, ":h")
  end

  return nil
end

--- Resolves path of the given rule name in tests land.
---
---@param name string
---@return string|nil
M.get_tests_path = function(name)
  local rules_path = string.format(
    "%s/lua/tests/ai/rules/%s.md",
    vim.fn.stdpath("config"),
    name
  )

  if vim.fn.filereadable(rules_path) == 1 then
    return rules_path
  end

  return nil
end

return M
