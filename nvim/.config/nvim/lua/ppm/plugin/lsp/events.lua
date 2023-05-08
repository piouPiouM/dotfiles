local plsp = require("ppm.lsp")
local M = {}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      autocmd!
      autocmd InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
    augroup HighlightWord
      autocmd!
      autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]]
  end

  if client.supports_method("textDocument/formatting") then
    plsp.event.format(plsp.format, client, bufnr)
  end
end

return M
