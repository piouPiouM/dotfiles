local telescope = require("telescope.builtin")
local u = require("ppm.utils")

local M = {}

M.mappings = function(bufnr)
  u.buf_map(bufnr, "n", "K", vim.lsp.buf.hover, "[LSP] Display symbol definition")
  u.buf_map(bufnr, "n", "ga", vim.lsp.buf.code_action, "[LSP] Display code actions")
  u.buf_map(bufnr, "x", "ga", vim.lsp.buf.range_code_action, "[LSP] Display code actions")
  u.buf_map(bufnr, "n", "gd", function() telescope.lsp_definitions() end, "[LSP] List definitions")
  u.buf_map(bufnr, "n", "gr", vim.lsp.buf.rename, "[LSP] Rename symbol")
  u.buf_map(bufnr, "n", "gk", vim.diagnostic.goto_prev, "[LSP] Go to previous diagnostic")
  u.buf_map(bufnr, "n", "gj", vim.diagnostic.goto_next, "[LSP] Go to next diagnostic")
  u.buf_map(bufnr, "n", "gD",
            function() vim.diagnostic.open_float(0, { severity_sort = true, scope = "line" }) end,
            "[LSP] Open diagnostic")
end

return M
