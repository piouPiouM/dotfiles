local M = {}

M.name = 'tsserver'
M.config = {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  on_attach = require('modules.lsp.events').on_attach
}

return M
