vim.opt.completeopt = { "menu", "menuone", "noselect" }

local u = require("ppm.utils")
local cmp = u.prequire "cmp"

if cmp == nil then return nil end

require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require("luasnip")
local filter = require("ppm.plugin.cmp.filtering")

vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "@conditional" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "TelescopeMatching" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "TelescopeMatching" })

cmp.setup({
  enabled = function()
    local disabled = false

    -- Keep default checks
    disabled = disabled or (vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt')
    disabled = disabled or (vim.fn.reg_recording() ~= '')
    disabled = disabled or (vim.fn.reg_executing() ~= '')

    -- Disable completion in comments
    local context = require("cmp.config.context")
    disabled = disabled or (vim.api.nvim_get_mode().mode == 'c')
    disabled = disabled or context.in_treesitter_capture("comment")
    disabled = disabled or context.in_syntax_group("Comment")

    return not disabled
  end,
  snippet = { expand = function(args) if luasnip ~= nil then luasnip.lsp_expand(args.body) end end },
  mapping = require("ppm.plugin.cmp.mapping"),
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    {
      name = "nvim_lsp",
      entry_filter = filter.some({
        filter.filters.keepMembersOnly,
      }),
    },
    { name = "calc" },
    {
      name = "luasnip",
      keyword_length = 1
    },
  }, {
    { name = "async_path" },
    {
      name = "treesitter",
      keyword_length = 3,
    },
    {
      name = "buffer",
      keyword_length = 5,
      option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    },
    {
      name = 'spell',
      option = {
        enable_in_context = function()
          return require('cmp.config.context').in_treesitter_capture('spell')
        end,
      },
    },
  }),
  sorting = require("ppm.plugin.cmp.sorting"),
  formatting = require("ppm.plugin.cmp.formatting"),
  experimental = { ghost_text = { hl_group = 'Comment' } },
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },
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
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  }
})

cmp.setup.cmdline(":", {
  completion = { autocomplete = true },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "async_path" } }, {
    { name = "cmdline", max_item_count = 30, keyword_length = 3 },
  }),
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  }
})
