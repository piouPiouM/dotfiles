vim.opt.completeopt = { "menu", "menuone", "noselect" }

local prequire = require("ppm.utils").prequire
local cmp = prequire "cmp"

if cmp == nil then return nil end

require("luasnip.loaders.from_vscode").lazy_load()

local k = require("ppm.keymaps")
local ui = require("ppm.ui")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
      vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "@conditional" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "TelescopeMatching" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "TelescopeMatching" })

cmp.setup({
  snippet = { expand = function(args) if luasnip ~= nil then luasnip.lsp_expand(args.body) end end },
  mapping = cmp.mapping.preset.insert({
    [k.scroll_up] = cmp.mapping.scroll_docs(-4),
    [k.scroll_down] = cmp.mapping.scroll_docs(4),
    [k.completion.complete] = cmp.mapping(cmp.mapping.complete()),
    ["<C-y>"] = cmp.config.disable,
    [k.completion.escape] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    -- LSP
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "luasnip",                keyword_length = 2 },

    -- Utils
    { name = "path",                   option = { trailing_slash = true } },
    { name = "calc" },
  }, {
    {
      name = "buffer",
      keyword_length = 5,
      option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    },
    { name = "spell" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = "symbol_text",
        preset = "codicons",
        maxwidth = 40,
        ellipsis_char = ui.icons.ellipsis,
        menu = {
          nvim_lua = ui.icons.lua,
          nvim_lsp = ui.icons.lsp,
          calc = ui.icons.calc,
          comment = ui.icons.comment,
          path = ui.icons.folder,
          treesitter = ui.icons.treesitter,
          luasnip = ui.icons.snippet,
          buffer = ui.icons.buffer,
        },
        -- symbol_map = { Snippet = codicons.get("symbol-snippet", "icon") },
      })(entry, vim_item)

      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      local menu = kind.menu or ""
      kind.kind = " " .. strings[1] .. " "

      if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
        kind.menu = menu .. "  " .. entry.completion_item.detail
      elseif #(strings) > 1 then
        kind.menu = menu .. "  (" .. strings[2]:lower() .. ")"
      end

      return kind
    end,
  },
  experimental = { ghost_text = true },
  window = {
    completion = {
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }),
})

cmp.setup.cmdline(":", {
  completion = { autocomplete = true },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } },
    { { name = "cmdline", max_item_count = 20, keyword_length = 4 } }),
})

-- cmp.setup.filetype("gitcommit", {
--   sources = cmp.config.sources({
--     { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
--   }, { { name = "buffer" } }),
-- })
