local M = {}

M.name = "efm"

local sh = {
  rootMarkers = {},
  lintCommand = "shellcheck --color=never --format=gcc -",
  lintSource = "shellcheck",
  lintStdin = true,
  lintFormats = { "-:%l:%c: %trror: %m", "-:%l:%c: %tarning: %m", "-:%l:%c: %tote: %m" },
  formatCommand = "shfmt -bn -ci -kp -sr -",
  formatStdin = true,
}

M.config = {
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
    goto_definition = false,
    locale = "fr",
  },
  filetypes = { "json", "jsonc", "sh", "bash", "zsh", "lua" },
  settings = { rootMarkers = { ".git/", "package.json" },
               languages = { bash = { sh }, sh = { sh } } },
}

return M
