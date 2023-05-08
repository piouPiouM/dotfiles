local u = require("ppm.utils")
local cursor = require("ppm.toolkit.cursor")
local cmp = u.prequire "cmp"
if cmp == nil then return {} end

local luasnip = require("luasnip")
local k = require("ppm.keymaps")

local M = cmp.mapping.preset.insert({
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
    elseif cursor.has_words_before() then
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
})

return M
