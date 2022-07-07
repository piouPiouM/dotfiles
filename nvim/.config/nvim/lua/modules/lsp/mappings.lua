local keymap = vim.keymap
local telescope = require("telescope.builtin")
local utils = require("ppm.utils")

local M = {}

M.mappings = function()
  local opts = function(...) return utils.keymap.with_desc(..., { buffer = true }) end

  keymap.set("n", "K", vim.lsp.buf.hover, opts("Display symbol definition"))
  keymap.set("n", "ga", vim.lsp.buf.code_action, opts("Display code actions"))
  keymap.set("x", "ga", vim.lsp.buf.range_code_action, opts("Display code actions"))
  keymap.set("n", "gd", function() telescope.lsp_definitions() end, opts("List definitions"))
  keymap.set("n", "gr", vim.lsp.buf.rename, opts("Rename symbol"))
  keymap.set("n", "gD",
             function() vim.diagnostic.open_float(0, { severity_sort = true, scope = "line" }) end,
             opts("Open diagnostic", { silent = true }))
end

return M
