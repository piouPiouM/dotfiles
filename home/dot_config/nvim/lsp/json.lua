return {
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(
      -- {
      --   select = {
      --     ".eslintrc",
      --     ".postcssrc",
      --     "babelrc.json",
      --     "Renovate",
      --     "package.json",
      --   },
      -- }
      ),
    },
  },
}