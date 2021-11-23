local nvim_lsp = require 'lspconfig'
local protocol = require 'vim.lsp.protocol'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  -- Avoid some errors
  if client.name == "vimls" then
     client.resolved_capabilities.code_action = false
  end

  -- Assumes that formatting is handled by eslint.
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.bashls.setup {}

-- nvim_lsp.vimls.setup {
--   capabilities = capabilities,
--   on_attach = on_attach
-- }

-- nvim_lsp.cucumber_language_server.setup {}
nvim_lsp.eslint.setup {}

nvim_lsp.tsserver.setup {
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities,
  on_attach = on_attach,
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require'schemastore'.json.schemas {
        select = {
          '.eslintrc',
          '.htmlhintrc',
          '.jshintrc',
          '.phraseapp.yml',
          '.postcssrc',
          '.pre-commit-config.yml',
          '.stylelintrc',
          '.yarnrc.yml',
          'babelrc.json',
          'helmfile',
          'jsconfig.json',
          'lerna.json',
          'package.json',
          'prettierrc.json',
          'tmLanguage',
          'tsconfig.json',
        },
      },
    },
  },
}

local servers = {
  'bashls',
  'cssls',
  'cucumber_language_server',
  'emmet_ls',
  'html',
  'vimls',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- flags = {
    --   debounce_text_changes = 150,
    -- }
  }
end

require'trouble'.setup {}