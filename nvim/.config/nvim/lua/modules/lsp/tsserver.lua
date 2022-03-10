local nnoremap = vim.keymap.nnoremap
local M = {}

M.name = "tsserver"
M.config = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {
      auto_inlay_hints = true,
      enable_formatting = true,
      enable_import_on_completion = true,
      eslint_bin = "eslint_d",
      eslint_enable_code_actions = true,
      eslint_enable_diagnostics = true,
      formatter = "prettier",
      require_confirmation_on_move = true,
      update_imports_on_move = true,
    }
    ts_utils.setup_client(client)

    local opts = { buffer = true }
    nnoremap { "go", ":TSLspOrganize<CR>", opts }
    nnoremap { "gR", ":TSLspRenameFile<CR>", opts }
    nnoremap { "gi", ":TSLspImportAll<CR>", opts }

    require("modules.lsp.events").on_attach(client)
  end,
}

return M
