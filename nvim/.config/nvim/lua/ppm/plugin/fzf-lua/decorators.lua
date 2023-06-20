local fp = require("ppm.toolkit.fp")
local themes = require("ppm.plugin.fzf-lua.themes")

local M = {}

M.with_title = fp.curry(function(label, opts)
  return vim.tbl_deep_extend("force", { winopts = { title = string.format(" %s ", label) } }, opts or {})
end)

-- @param name Theme: name of the theme to apply to the given options.
-- @return a function
M.with_theme = fp.curry(function(name, opts)
  local theme = themes[name]
  local config = type(theme) == "function" and theme(opts) or theme

  return type(opts) == "table" and vim.tbl_deep_extend("force", config, opts) or config
end)

M.with_history = fp.curry(function(type, opts)
  return vim.tbl_deep_extend("force", {
    fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-" .. type },
  }, opts or {})
end)

function M.without_history()
  return function(opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      fzf_opts = { ["--history"] = false },
    })
  end
end

return M
