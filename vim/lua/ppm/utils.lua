local M = {}

local function prequire(...)
  local status, lib = pcall(require, ...)

  if status then return lib end
  return nil
end

M.prequire = prequire

-- { "─", "│", " ", "│", "╭", "╮", "│", "│" }

M.borders = {
  simple = 'simple',
  rounded = 'rounded',
  fancy = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  solid =   { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' },
}

return M
