local cursor = require("ppm.toolkit.cursor")
local fp = require("ppm.toolkit.fp")
local log = require("ppm.toolkit.log")
local path = require("ppm.toolkit.path")
local strings = require("ppm.toolkit.string")

local M = vim.tbl_deep_extend("force", {}, log, {
  cursor = cursor,
  fp = fp,
  path = path,
  strings = strings
})

return M
