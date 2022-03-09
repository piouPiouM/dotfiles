local nightfox = require("nightfox")
local M = {}

M.setup = function() nightfox.setup({ fox = "nordfox", alt_nc = true }) end

M.set = function() nightfox.load() end

return M
