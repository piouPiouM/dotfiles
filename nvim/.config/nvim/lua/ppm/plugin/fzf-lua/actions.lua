local actions = require("fzf-lua.actions")

local M = {}

function M.insert(selected, opts)
  actions.complete_insert(type(selected) == table and selected or {
    selected,
  }, opts)
end

function M.paste(selected) vim.api.nvim_paste(selected, false, -1) end

return M
