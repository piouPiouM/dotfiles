local M = require("lualine.component"):extend()

function M:init(options)
  M.super.init(self, options)
end

function M:update_status()
  local reg = vim.fn.reg_recording()

  return reg == "" and "" or string.format("󰑊 @%s", reg)
end

return M
