local M = {}

local codicon = {
  bulb = "",
  cross = "",
  help = "",
  info = "",
  warn = "",
  caret = "",
  search = "",
  comment = "",
}

M.icons = vim.tbl_extend("force", codicon, { error = codicon.cross, hint = codicon.comment })

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
