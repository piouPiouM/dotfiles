local M = {}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

M.name = 'efm'
M.config = {
  init_options = {
    documentFormatting = true,
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
    "typescriptreact"
  },
  settings = {
    -- rootMarkers = {'.git/', 'package.json'},
    languages = {
      javascript = { eslint },
      typescript = { eslint },
    --   lua = {
    --     {formatCommand = 'lua-format -i', formatStdin = true}
    --   }
    }
  }
}

return M
