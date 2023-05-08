local api = vim.api
local k = require("ppm.keymaps")
local u = require("ppm.utils")

local M = {}

M.set_mappings = function(bufnr)
  u.buf_map(bufnr, "n", k.lsp.diagnostic.previous.key, [[<cmd>Lspsaga diagnostic_jump_prev<cr>]],
    k.lsp.diagnostic.previous.desc)
  u.buf_map(bufnr, "n", k.lsp.diagnostic.next.key, [[<cmd>Lspsaga diagnostic_jump_next<cr>]],
    k.lsp.diagnostic.next.desc)
  u.buf_map(bufnr, "n", k.lsp.diagnostic.line.key, [[<cmd>Lspsaga show_line_diagnostics<cr>]],
    k.lsp.diagnostic.line.key)
end

M.set_options = function(bufnr)
  api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

return M
