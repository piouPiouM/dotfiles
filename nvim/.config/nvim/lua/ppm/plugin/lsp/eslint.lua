local plsp = require("ppm.lsp")
local M = {}

M.config = {
  on_attach = function(client, bufnr) plsp.event.format("EslintFixAll", client, bufnr) end,
}

return M
