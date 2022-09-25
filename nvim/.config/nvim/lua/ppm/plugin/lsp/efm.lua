local M = {}

M.name = "efm"

local eslint = {
  lintCommand = "eslint_d --cache --no-color --format unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --cache --no-color --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true,
}

local sh = {
  rootMarkers = {},
  lintCommand = "shellcheck --color=never --format=gcc -",
  lintSource = "shellcheck",
  lintStdin = true,
  lintFormats = { "-:%l:%c: %trror: %m", "-:%l:%c: %tarning: %m", "-:%l:%c: %tote: %m" },
  formatCommand = "shfmt -",
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
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "sh",
    "bash",
    "lua",
  },
  settings = {
    rootMarkers = { ".git/", "package.json" },
    languages = {
      javascript = { eslint },
      typescript = { eslint },
      bash = { sh },
      sh = { sh },
      lua = {
        {
          formatCommand = "lua-format --config=$XDG_CONFIG_HOME/luaformatter/config.yaml -i",
          formatStdin = true,
        },
      },
    },
  },
}

return M
