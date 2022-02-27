vim.opt.completeopt = "menuone,noinsert,noselect"

local prequire = require("ppm.utils").prequire
local cmp = prequire "cmp"
local lspkind = prequire "lspkind"
local luasnip = prequire "luasnip"
local codicons = require "codicons"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  },
  sources = cmp.config.sources({
    -- LSP
    { name = "nvim_lsp" }, { name = "treesitter" }, { name = "nvim_lua" }, { name = "luasnip" },

    -- Utils
    { name = "path" }, { name = "calc" }, {
      name = "buffer",
      keyword_length = 5,
      option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    }, { name = "spell" },
  }),
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol",
      preset = "codicons",
      maxwidth = 60,
      menu = {
        nvim_lua = "",
        nvim_lsp = codicons.get("rocket"),
        calc = "",
        path = codicons.get("file-submodule"),
        treesitter = codicons.get("type-hierarchy"),
        luasnip = codicons.get("hubot"),
        buffer = codicons.get("layers"),
      },
      symbol_map = { Snippet = codicons.get("symbol-snippet") },
    },
  },
  experimental = { ghost_text = true },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "nvim_lsp_document_symbol" }, { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  completion = { autocomplete = true },
  sources = cmp.config.sources({ { name = "path" } },
                               { { name = "cmdline", max_item_count = 20, keyword_length = 4 } }),
})
