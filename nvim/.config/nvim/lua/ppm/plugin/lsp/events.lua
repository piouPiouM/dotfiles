local M = {}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.codeActionProvider then require("ppm.plugin.lightbulb") end

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

  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
    augroup Format
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
    augroup END
    ]]
    vim.cmd [[command! Format lua vim.lsp.buf.format()]]
  end

  require("ppm.plugin.lsp.mappings").mappings(bufnr)
end

return M
