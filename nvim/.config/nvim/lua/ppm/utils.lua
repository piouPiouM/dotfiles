local M = {}

local function prequire(...)
  local status, lib = pcall(require, ...)

  if status then return lib end
  return nil
end

M.keymap = {
  with_desc = function(desc, ...)
    local options = { desc = desc }

    print(vim.inspect(select("#", ...)))
    if select("#", ...) > 0 then return vim.tbl_extend("force", ..., options) end

    return options
  end,
}

M.prequire = prequire

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
