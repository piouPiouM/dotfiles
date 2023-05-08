local M = {}

M.name = "lua_ls"
M.config = {
  -- not working 🤔
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.documentFormattingProvider = true
  --   client.server_capabilities.documentRangeFormattingProvider = true
  -- end,
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      hint = { enable = true },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

return M
