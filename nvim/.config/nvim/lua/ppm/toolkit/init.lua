local cursor = require("ppm.toolkit.cursor")
local log = require("ppm.toolkit.log")
local path = require("ppm.toolkit.path")
local strings = require("ppm.toolkit.string")

local M = vim.tbl_deep_extend("force", {}, log, {
  cursor = cursor,
  path = path,
  strings = strings
})

return M
