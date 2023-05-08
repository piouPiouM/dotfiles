local lspconfig = require("lspconfig")
local events = require("ppm.plugin.lsp.events")

require "ppm.plugin.lsp.diagnostic"

-- Customize keybiding and options on `LspAttach` event emit by Neovim each time
-- a language server is attached to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Performs LSP customization when a server is attached",
  callback = function(info)
    local lsp_common = require("ppm.plugin.lsp.common")
    lsp_common.set_mappings(info.buf)
    lsp_common.set_options(info.buf)
  end,
})

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities(), {
    textDocument = {
      completion = { completionItem = { insertTextModeSupport = { valueSet = { 2 } } } },
    },
  })

local servers = {
  astro = {},
  lua_ls = require("ppm.plugin.lsp.lua_ls").config,
  jsonls = require("ppm.plugin.lsp.json").config,
  eslint = require("ppm.plugin.lsp.eslint").config,
  html = {},
  cssls = {},
  bashls = {},
  cucumber_language_server = {},
  emmet_ls = {},
  efm = require("ppm.plugin.lsp.efm").config,
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
      capabilities = lsp_defaults.capabilities,
    }, opts))
  end
end
