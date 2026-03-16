local api = vim.api
local plsp = require("ppm.lsp")
local k = require("ppm.keymaps")
local u = require("ppm.utils")
local ui = require("ppm.ui")

local signs = {
  Error = ui.icons.error,
  Warn = ui.icons.warn,
  Hint = ui.icons.bulb,
  Info = ui.icons.info,
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = false,
  float = { border = ui.borders.rounded, header = "", max_width = 80 },
}

local servers = {
  astro = { format = false },
  lua_ls = { format = false },
  jsonls = { format = false },
  ts_ls = { format = false },
  html = { format = true },
  cssls = { format = false },
  css_variables = { format = true },
  cssmodules_ls = { format = true },
  ast_grep = { format = false },
  mdx_analyzer = { format = false },
  -- remark_ls = { format = false },
  bashls = { format = false },
  -- cucumber_language_server = { format = false },
  eslint = { format = "LspEslintFixAll" },
  emmet_language_server = { format = false },
  biome = { format = true },
  stylelint_lsp = { format = true },
  efm = { format = true },
  yamlls = { format = true },
}

api.nvim_create_autocmd("LspAttach", {
  desc = "Performs LSP customization when a server is attached",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/documentColor") then
      client.server_capabilities.colorProvider = false
    end

    if servers[client.name] and servers[client.name].format then
      if type(servers[client.name].format) == "string" then
        plsp.event.format(servers[client.name].format, client, args.buf)
      elseif client:supports_method("textDocument/formatting") then
        plsp.event.format(plsp.format, client, args.buf)
      end
    end

    u.buf_map(args.buf, "n", k.lsp.diagnostic.previous.key, [[<cmd>Lspsaga diagnostic_jump_prev<cr>]],
              k.lsp.diagnostic.previous.desc)
    u.buf_map(args.buf, "n", k.lsp.diagnostic.next.key, [[<cmd>Lspsaga diagnostic_jump_next<cr>]],
              k.lsp.diagnostic.next.desc)
    u.buf_map(args.buf, "n", k.lsp.diagnostic.line.key, [[<cmd>Lspsaga show_line_diagnostics<cr>]],
              k.lsp.diagnostic.line.key)

    api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = args.buf })
    api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = args.buf })
    api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = args.buf })
  end,
})

local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities() or {},
  require("cmp_nvim_lsp").default_capabilities(),
  {
    textDocument = {
      completion = {
        completionItem = {
          insertTextModeSupport = {
            valueSet = { 2 } },
        },
      },
      offsetEncoding = "utf-16",
    },
  })

vim.lsp.config("*", {
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
});

for name, _ in pairs(servers) do
  P("enable lsp:" .. name)
  vim.lsp.enable(name)
end