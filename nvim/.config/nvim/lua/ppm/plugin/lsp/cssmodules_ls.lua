local M = {}

M.name = "cssmodules_ls"
M.config = {
  on_attach = function(client, bufnr)
    -- Prevents conflict with TypeScript server.
    client.server_capabilities.definitionProvider = false
  end,
}

return M