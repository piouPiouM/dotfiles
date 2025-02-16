local M = {}

M.name = "ts_ls"
M.config = {
  on_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
  end,
}

return M