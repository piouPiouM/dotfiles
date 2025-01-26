local pkind = require("ppm.plugin.cmp.kind")
local pk_path = require("ppm.toolkit.path")
local ui = require("ppm.ui")

local function format_source(name)
  local source_icon = {
    buffer = ui.icons.buffer,
    calc = ui.icons.calc,
    comment = ui.icons.comment,
    copilot = ui.icons.copilot,
    luasnip = ui.icons.snippet,
    nvim_lsp = ui.icons.lsp,
    nvim_lua = ui.icons.lua,
    path = ui.icons.folder,
    asyn_path = ui.icons.folder,
    treesitter = ui.icons.treesitter,
    rg = ui.icons.rg,
  }

  return source_icon[name:lower()] or ""
end

local function format_detail(detail)
  -- pkit.log.info(vim.inspect(detail))
  -- pkit.log.info(vim.inspect(pkit.with_tilde(detail)))
  -- pkit.log.info(vim.inspect(pkit.shorten_path(detail)))

  if not detail:find("/") then
    return detail
  end

  return pk_path.shorten_path(pk_path.with_tilde(detail))
end

local function format_entry(entry, vim_item)
  local kind = pkind.get_icon(vim_item.kind)
  local menu = { vim_item.menu or "" }
  local source = entry.source.name
  local detail = entry.completion_item.detail

  if #(source) > 1 then
    table.insert(menu, format_source(source))
  end

  if detail ~= nil and detail ~= "" then
    table.insert(menu, format_detail(detail))
  end

  vim_item.kind = string.format(" %s", kind)
  vim_item.menu = table.concat(menu, " ")

  return vim_item
end

return {
  expandable_indicator = false,
  fields = { "kind", "abbr", "menu" },
  format = format_entry,
}