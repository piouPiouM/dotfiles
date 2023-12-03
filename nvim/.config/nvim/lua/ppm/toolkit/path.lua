local telescope_utils = require("telescope.utils")
local F = require("ppm.toolkit.fp")
local S = require("ppm.toolkit.fp.string")
local pipe = F.pipe

local M = {}

local home_trimed = pipe(vim.env.HOME, S.trim_start("/"))

--- Converts user directory to tidle notation.
---
---@param path string Path to manipulate.
---@return string
M.with_tilde = S.replace_first("^" .. home_trimed, "~")

--- Shorten given path by omitting middle paths.
---
---@param path string Long path to shorten.
---@return string
function M.shorten_path(path)
  return telescope_utils.transform_path({
    path_display = {
      shorten = { len = 2, exclude = { 1, 2, -2, -1 } }
    }
  }, path)
end

-- M.relative_path_prefix = function(path)
--   local prefix
--   if finder.prompt_path then
--     local path, _ = Path:new(finder.path):make_relative(finder.cwd):gsub(vim.fn.expand "~", "~")
--     if path:match "^%w" then
--       prefix = "./" .. path .. os_sep
--     else
--       prefix = path .. os_sep
--     end
--   end
--
--   return prefix
-- end

return M