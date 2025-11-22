local api = vim.api
local plsp = require("ppm.lsp")
local k = require("ppm.keymaps")
local u = require("ppm.utils")
local ui = require("ppm.ui")

local signs = {
  Error = ui.icons.error,
  Warn = ui.icons.warn,
  Hint = ui.icons.bulb,
  Info = ui.icons.info
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
  cssls = { format = true },
  css_variables = { format = true },
  cssmodules_ls = { format = true },
  ast_grep = { format = false },
  mdx_analyzer = { format = false },
  -- remark_ls = { format = false },
  bashls = { format = false },
  -- cucumber_language_server = { format = false },
  eslint = {
    -- eslint server provide a `LspEslintFixAll` command to fix all auto-fixable.
    format = false
  },
  emmet_language_server = { format = false },
  biome = { format = true },
  stylelint_lsp = { format = true },
  efm = { format = true },
  yamlls = { format = true },
}

-- Get the background color from the Normal highlight group
local function get_theme_bg()
  local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })

  if normal_hl.bg then
    -- Convert decimal to hex
    return string.format("#%06x", normal_hl.bg)
  end

  -- Fallback: check if background is dark or light
  if vim.o.background == "dark" then
    return "#000000"
  else
    return "#ffffff"
  end
end

api.nvim_create_autocmd("LspAttach", {
  desc = "Performs LSP customization when a server is attached",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if servers[client.name] then
      if servers[client.name].format and client:supports_method("textDocument/formatting") then
        plsp.event.format(plsp.format, client, args.buf)
      end

      if client:supports_method("textDocument/documentColor") then
        local ns_id = vim.api.nvim_create_namespace("document_color_virtual")

        local virtual_after_color = function(bufnr, range, hex_code)
          -- Validate inputs
          if not range or not hex_code then
            return
          end

          -- Range format: { start_line, start_col, end_line, end_col }
          -- LSP uses 0-indexed positions, nvim_buf_set_extmark also uses 0-indexed lines
          local end_line = range[3]
          local end_col = range[4]

          if not end_line or not end_col then
            return
          end

          -- Get the line text and validate column
          local line_text = vim.api.nvim_buf_get_lines(bufnr, end_line, end_line + 1, false)[1]
          if not line_text then
            return
          end

          local line_len = #line_text

          -- Ensure end_col is within bounds
          if end_col > line_len then
            end_col = line_len
          end

          -- Check if there's a quote after the color
          if end_col < line_len and line_text:sub(end_col + 1, end_col + 1):match('["\']') then
            end_col = end_col + 1
          end

          -- Create a unique ID for this extmark based on position
          local extmark_id = (end_line + 1) * 100000 + end_col

          -- Create highlight group for the color swatch
          local hl_name = "DocumentColor_" .. hex_code:gsub("#", "")
          local bg_color = get_theme_bg()
          vim.api.nvim_set_hl(0, hl_name, { fg = hex_code, bg = bg_color })

          -- Set the virtual text with the color swatch and hex code
          vim.api.nvim_buf_set_extmark(bufnr, ns_id, end_line, end_col, {
            id = extmark_id,
            virt_text = {
              { " 󱓻 ", hl_name },
            },
            virt_text_pos = "inline",
            hl_mode = "combine",
          })
        end

        vim.lsp.document_color.enable(true, args.buf, { style = virtual_after_color })
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

local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities() or {},
  require("cmp_nvim_lsp").default_capabilities(), {
    textDocument = {
      completion = {
        completionItem = {
          insertTextModeSupport = {
            valueSet = { 2 } }
        }
      },
      offsetEncoding = 'utf-16'
    },
  })

vim.lsp.config('*', {
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
});

for name, _ in pairs(servers) do
  vim.lsp.enable(name)
end
