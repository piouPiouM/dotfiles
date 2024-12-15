local ui = require("ppm.ui")
local signs = {
  Error = ui.icons.error,
  Warn = ui.icons.warn,
  Hint = ui.icons.bulb,
  Info = ui.icons.info
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = false,
  float = { border = ui.borders.rounded, header = false, max_width = 80 },
}