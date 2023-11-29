local M = {}

local css_modules_settings = {
  lint = {
    validProperties = { "composes" }
  }
}

M.name = 'cssls'
M.config = {
  settings = {
    css = css_modules_settings
  }
}

return M
