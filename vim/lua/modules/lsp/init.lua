local lspconfig = require 'lspconfig'
local events    = require 'modules.lsp.events'

require 'modules.lsp.diagnostic'

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.documentationFormat = {
  'markdown',
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = {
--   valueSet = { 1 },
-- }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     "documentation",
--     "detail",
--     "additionalTextEdits",
--   },
-- }

local servers = {
  tsserver = require('modules.lsp.tsserver').config,
  sumneko_lua = require('modules.lsp.sumneko').config,
  jsonls = require('modules.lsp.json').config,
  html = {},
  cssls = {},
  bashls = {},
  eslint = {},
  cucumber_language_server = {},
  emmet_ls = {},
}

for name, opts in pairs(servers) do
  if type(opts) == 'function' then
    opts()
  else
    local client = lspconfig[name]
    client.setup(vim.tbl_extend('force', {
      flags = { debounce_text_changes = 150 },
      on_attach = events.on_attach,
      on_init = events.on_init,
      capabilities = capabilities,
    }, opts))
  end
end

require('trouble').setup {}

