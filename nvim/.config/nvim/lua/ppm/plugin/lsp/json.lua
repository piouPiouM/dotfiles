local M = {}

M.name = "jsonls"
M.config = {
  on_attach = require("ppm.plugin.lsp.events").on_attach,
  settings = {
    -- json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
}

return M
