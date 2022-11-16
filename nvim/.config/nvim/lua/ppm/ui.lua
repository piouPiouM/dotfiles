local codicons = require("codicons")

local M = {}

local codicon = function(name) return codicons.get(name, "icon") end

M.icons = {
  bulb = codicon("bulb"),
  caret = codicon("chevron-right"),
  error = codicon("error"),
  help = codicon("question"),
  hint = codicon("comment"),
  info = codicon("info"),
  search = codicon("search"),
  warn = codicon("warning"),
  action = codicon("github-action"),
  folder = codicon("folder"),
  ellipsis = "…",
  lua = "",
  lsp = codicon("server-environment"),
  treesitter = codicon("type-hierarchy"),
  snippet = codicon("rocket"),
  buffer = codicon("layers"),
  calc = codicon("pie-chart"),
}

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
