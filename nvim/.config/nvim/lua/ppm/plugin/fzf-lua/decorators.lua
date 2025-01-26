local fp = require("ppm.toolkit.fp")

local M = {}

M.with_title = fp.curry(function(label, opts)
  return vim.tbl_deep_extend("force", {
    winopts = {
      title = string.format(" %s ", label) }
  }, opts or {})
end)

-- @param name Theme: name of the theme to apply to the given options.
-- @return a function
M.with_theme = fp.curry(function(name, opts)
  local theme = require(string.format("ppm.plugin.fzf-lua.themes.%s", name))
  local config = type(theme) == "function" and theme(opts) or theme

  return vim.tbl_deep_extend("force", opts or {}, config)
end)

M.with_history = fp.curry(function(type, opts)
  return vim.tbl_deep_extend("force", {
    fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-" .. type },
  }, opts or {})
end)

M.without_history = function()
  return function(opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      fzf_opts = { ["--history"] = false },
    })
  end
end

M.disable_preview = function()
  return function(opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      winopts = {
        preview = { hidden = true },
      }
    })
  end
end

M.extend = function(config)
  return function(opts)
    return vim.tbl_deep_extend("force", opts or {}, config or {})
  end
end

return M
