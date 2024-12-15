local M = {}

M.name = 'cssls'
M.config = {
  settings = {
    css = {
      lint = {
        emptyRules = "ignore",
        unknownAtRules = "ignore",
        validProperties = { "composes" }
      }
    }
  }
}

return M
