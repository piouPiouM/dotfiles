local M = {}

M.on_init = function(client)
  vim.notify(" " .. client.name .. ": Language Server Client successfully started!", "info")
  -- print(vim.inspect(client.resolved_capabilities))
end

M.on_attach = function(client)
  if client.resolved_capabilities.code_action then require "modules.lsp.lightbulb" end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      autocmd!
      autocmd InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
    augroup HighlightWord
      autocmd!
      autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]]
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
    augroup Format
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
    augroup END
    ]]
    vim.cmd [[command! Format lua vim.lsp.buf.formatting_seq_sync()]]
  end

  require("modules.lsp.mappings").mappings()
end

return M
