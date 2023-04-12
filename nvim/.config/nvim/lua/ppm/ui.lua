local fun = require("fun")
local codicons = require("codicons")

local M = {}

M.icons = fun.iter({
  bulb = "bulb", -- FIXME
  caret = "chevron-right",
  comment = "comment",
  error = "error",
  help = "question",
  hint = "comment",
  info = "info",
  search = "search",
  warn = "warning",
  action = "github-action",
  folder = "folder",
  ellipsis = "…",
  lua = " ",
  lsp = "server-environment",
  treesitter = "type-hierarchy",
  snippet = "rocket",
  buffer = "layers",  -- FIXME
  calc = "pie-chart", -- FIXME
  expand = "chevron-right",
  collapse = "chevron-down",
  incoming = "call-incoming",
  outgoing = "call-outgoing",
  hover = " ",
  actionfix = "lightbulb-autofix",
}):map(function(name, icon_name)
  local icon = codicons.get(icon_name, "icon")

  return name, (icon ~= nil and icon .. " " or
      (vim.fn.strdisplaywidth(icon_name) < 3 and icon_name or ""))
end):tomap()

M.borders = {
  simple = "simple",
  rounded = "rounded",
  fancy = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  solid = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
}

M.box = {
  TOP = "─",
  BOTTOM = "─",
  RIGHT = "│",
  SPACE = " ",
  LEFT = "│",
  CORNER = { TOP_LEFT = "╭", TOP_RIGHT = "╮" },
}

return M
