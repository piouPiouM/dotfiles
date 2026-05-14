local M = {}

M.name = "yamlls"
M.config = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    require("ppm.plugin.lsp.events").on_attach(client, bufnr)
  end,
  settings = {
    redhat = {
      telemetry = {
        enabled = false
      }
    },
    yaml = {
      editor = {
        tabSize = 4,
        insertSpaces = true,
        formatOnType = true,
      },
      format = {
        bracketSpacing = false,
        enable = true,
        printWidth = 120,
      },
      hover = true,
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas {
        -- select = {
        --   'lazygit',
        --   'docker-compose.yml'
        -- },
      }
    },
  },
}

return M