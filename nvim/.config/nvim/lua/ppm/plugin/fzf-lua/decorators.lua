local fp = require("ppm.toolkit.fp")
local themes = require("ppm.plugin.fzf-lua.themes")

local M = {}

function M.title(label) return string.format(" %s ", label) end

M.with_title = fp.curry(function(label, opts)
  return vim.tbl_deep_extend("force", { winopts = { title = M.title(label) } }, opts)
end)

-- @param name Theme: name of the theme to apply to the given options.
-- @return a function
function M.with_theme(name)
  return function(opts)
    local theme = themes[name]
    local config = type(theme) == "function" and theme(opts) or theme
    return type(opts) == "table" and vim.tbl_deep_extend("force", config, opts) or config
  end
end

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