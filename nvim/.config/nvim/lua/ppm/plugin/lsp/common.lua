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
  api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
  api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
end

return M