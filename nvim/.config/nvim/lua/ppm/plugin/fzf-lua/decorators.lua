local fp = require("moses")

local M = {}

function M.title(label) return string.format(" %s ", label) end

M.with_title = fp.curry(function(label, opts)
  return vim.tbl_deep_extend("force", { winopts = { title = M.title(label) } }, opts)
end)

M.with_history = fp.curry(function(type, opts)
  return vim.tbl_deep_extend("force", {
    fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-" .. type },
  }, opts)
end)

function M.without_history(opts)
  return vim.tbl_deep_extend("force", opts, {
    fzf_opts = { ["--history"] = false },
  })
end

return M
