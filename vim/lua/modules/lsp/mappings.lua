local k = vim.keymap
local nnoremap = k.nnoremap
-- local inoremap = k.inoremap
-- local vnoremap = k.vnoremapocal
local telescope = require 'telescope.builtin'

local M = {}

M.mappings = function ()
  local opts = { buffer = true }

  nnoremap { 'K', vim.lsp.buf.hover, opts }
  nnoremap { 'ga', telescope.lsp_code_actions, opts }
  nnoremap { 'gd', telescope.lsp_definitions, opts }
  nnoremap { 'gr', vim.lsp.buf.rename, opts }
  nnoremap {
    "gD",
    function()
      vim.diagnostic.open_float(0, {
        severity_sort = true,
        scope = 'line',
      })
    end,
    { silent = true },
  }
end

return M
