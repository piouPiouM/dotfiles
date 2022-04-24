local nightfox = require("nightfox")
local M = {}

M.setup = function() nightfox.setup({ options = { dim_inactive = true } }) end

M.set = function() vim.cmd("colorscheme nordfox") end

return M
