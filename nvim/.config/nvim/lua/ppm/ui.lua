local codicon = {
  bulb = "",
  cross = "",
  help = "",
  info = "",
  warn = "",
  caret = "",
  search = "",
}

local M = {}

M.icons = codicon

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
