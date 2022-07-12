local group = vim.api.nvim_create_augroup("LightBulb", {})
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = group,
  desc = "Show a lightbulb if a code action is available at the current cursor position",
  callback = require("nvim-lightbulb").update_lightbulb,
})
