local keymap = vim.keymap
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
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

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
    keymap.set("n", "go", ":TSLspOrganize<CR>", opts)
    keymap.set("n", "gR", ":TSLspRenameFile<CR>", opts)
    keymap.set("n", "gi", ":TSLspImportAll<CR>", opts)

    require("modules.lsp.events").on_attach(client)
  end,
}

return M
