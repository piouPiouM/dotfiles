local M = {}

M.name = "jsonls"
M.config = {
  on_attach = require("ppm.plugin.lsp.events").on_attach,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas {
        select = {
          ".eslintrc",
          ".htmlhintrc",
          ".jshintrc",
          ".phraseapp.yml",
          ".postcssrc",
          ".pre-commit-config.yml",
          ".stylelintrc",
          ".yarnrc.yml",
          "babelrc.json",
          "helmfile",
          "jsconfig.json",
          "lerna.json",
          "package.json",
          "prettierrc.json",
          "tmLanguage",
          "tsconfig.json",
        },
      },
    },
  },
}

return M
