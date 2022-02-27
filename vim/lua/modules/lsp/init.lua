local lspconfig = require "lspconfig"
local events = require "modules.lsp.events"

require "modules.lsp.diagnostic"

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol
                                                                     .make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.insertTextModeSupport = { valueSet = { 2 } }
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local servers = {
  tsserver = require("modules.lsp.tsserver").config,
  sumneko_lua = require("modules.lsp.sumneko").config,
  jsonls = require("modules.lsp.json").config,
  eslint = require("modules.lsp.eslint").config,
  html = {},
  cssls = {},
  bashls = {},
  cucumber_language_server = {},
  emmet_ls = {},
  efm = require("modules.lsp.efm").config,
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = lspconfig[name]
    client.setup(vim.tbl_extend("force", {
      flags = { debounce_text_changes = 150 },
      on_attach = events.on_attach,
      on_init = events.on_init,
      capabilities = capabilities,
    }, opts))
  end
end

require("trouble").setup {}

