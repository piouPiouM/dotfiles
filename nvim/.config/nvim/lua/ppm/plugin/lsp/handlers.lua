-- local api = vim.api
-- local fn = vim.fn
-- local lsp = vim.lsp

-- lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
--   border = Util.borders,
-- })

-- lsp.handlers['textDocument/signatureHelp'] = lsp.with(
--   lsp.handlers.signature_help,
--   {
--     border = Util.borders,
--   }
-- )

-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
-- lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
--   if err ~= nil or result == nil then
--     return
--   end

--   if not api.nvim_buf_get_option(bufnr, "modified") then
--     local view = fn.winsaveview()
--     lsp.util.apply_text_edits(result, bufnr)
--     fn.winrestview(view)

--     if bufnr == api.nvim_get_current_buf() then
--       api.nvim_command("noautocmd :update")
--     end
--   end
-- end
