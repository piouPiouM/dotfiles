local get_map_options = function(desc, ...)
  local options = { desc = desc, silent = true }

  if select("#", ...) > 0 then options = vim.tbl_extend("force", options, ...) end

  return options
end

local M = {}

M.map = function(mode, target, source, desc, ...)
  vim.keymap.set(mode, target, source, get_map_options(desc, ...))
end

for _, mode in ipairs({ "n", "i", "v", "o", "x", "t", "c" }) do
  M[mode .. "map"] = function(...) M.map(mode, ...) end
end

M.buf_map = function(bufnr, mode, target, source, desc, ...)
  local opts = ... or {}
  opts.buffer = bufnr

  M.map(mode, target, source, desc, opts)
end

M.prequire = function(...)
  local status, lib = pcall(require, ...)

  if status then return lib end
  return nil
end

return M
