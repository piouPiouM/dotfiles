local api = vim.api
local plsp = require("ppm.lsp")

api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.name ~= "eslint" then return end

    local bufnr = args.buf

    plsp.event.format("LspEslintFixAll", client, bufnr)
  end,
})

-- api.nvim_create_autocmd("LspDetach", {
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client.name ~= "eslint" then return end
--
--     api.nvim_buf_del_user_command(0, "Format")
--     vim.keymap.del('n', '<Leader>=', { buffer = true, desc = "Format current buffer with LSP" })
--   end,
-- })