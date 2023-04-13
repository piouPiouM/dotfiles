local api = vim.api
local M = {}

local function skipFormatting(client) return client.name ~= "tsserver" end

M.format = function(bufnr) vim.lsp.buf.format({ filter = skipFormatting, bufnr = bufnr }) end

M.event = {
  format = function(callback, client, bufnr)
    local make_formater = function()
      if type(callback) == "string" then
        vim.cmd(callback)
      else
        callback(bufnr)
      end
    end

    local augroup = api.nvim_create_augroup("PpmLspFormatting", { clear = true })

    api.nvim_create_autocmd("BufWritePre",
                            { group = augroup, buffer = bufnr, callback = make_formater })

    api.nvim_buf_create_user_command(bufnr, "Format", make_formater,
                                     { desc = "Format current buffer with LSP" })
  end,
}

return M
