local ui = require "ppm.ui"
local M = {}

M.lightbulb = function()
  require"nvim-lightbulb".update_lightbulb {
    sign = { enabled = true, text = ui.icons.bulb, priority = 15 },
    virtual_text = { enabled = false },
  }
end

return M
