local nightfox = require("nightfox")
local M = {}

M.setup = function() nightfox.setup({ options = { dim_inactive = true } }) end

M.use = function() vim.cmd("colorscheme dawnfox") end

return M
