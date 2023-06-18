local M = {}

M.icons = {
  -- completion
  comment = " ",
  lua = "󰢱 ",
  lsp = "",
  treesitter = " ",
  snippet = "󱐋",
  buffer = " ",
  calc = "󱖦 ",
  ellipsis = " ",
  -- diagnostic / log
  error = " ",
  warn = " ",
  info = " ",
  debug = " ",
  trace = " ",
  -- git
  diff = " ",
  diff_added = " ",
  diff_ignored = " ",
  diff_modified = " ",
  diff_removed = " ",
  diff_renamed = " ",
  git_head = "",
  -- lsp
  action = " ",
  actionfix = " ",
  bulb = "",
  help = " ",
  hint = " ",
  incoming = " ",
  outgoing = " ",
  -- navigation
  caret = "",
  expand = "",
  collapse = " ",
  folder = " ",
  search = " ",
  hover = " ",
  modified = "",
  readonly = "󰒃 ",
  -- misc
  history = " ",
  terminal = " ",
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
