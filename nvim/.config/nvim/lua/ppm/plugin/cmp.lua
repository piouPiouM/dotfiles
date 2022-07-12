vim.opt.completeopt = "menuone,noinsert,noselect"

local prequire = require("ppm.utils").prequire
local cmp = prequire "cmp"
local lspkind = prequire "lspkind"
local luasnip = prequire "luasnip"
local codicons = prequire "codicons"

if cmp == nil then return nil end

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip ~= nil then
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
    -- ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
  sources = cmp.config.sources({
    -- LSP
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "luasnip" },

    -- Utils
    { name = "path" },
    { name = "calc" },
    {
      name = "buffer",
      keyword_length = 5,
      option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    },
    { name = "spell" },
  }),
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol",
      preset = "codicons",
      maxwidth = 60,
      menu = {
        nvim_lua = "",
        nvim_lsp = codicons.get("hubot", "icon"),
        calc = "",
        path = codicons.get("file-submodule", "icon"),
        treesitter = codicons.get("type-hierarchy", "icon"),
        luasnip = codicons.get("squirrel", "icon"),
        buffer = codicons.get("layers", "icon"),
      },
      symbol_map = { Snippet = codicons.get("symbol-snippet", "icon") },
    },
  },
  experimental = { ghost_text = true },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  completion = { autocomplete = true },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } },
    { { name = "cmdline", max_item_count = 20, keyword_length = 4 } }),
})
