local M = {}

M.name = 'tsserver'
M.config = {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function (client)
    client.resolved_capabilities.document_formatting = false

    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup {
      auto_inlay_hints = true,
      enable_import_on_completion = true,
      update_imports_on_move = true,
      require_confirmation_on_move = true,
    }
    ts_utils.setup_client(client)

    require('modules.lsp.events').on_attach(client)
  end
}

return M
