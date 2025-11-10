return {
  settings = {
    yaml = {
      validate = true,
      format = true,
      -- disable the schema store
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas({
        -- select = {
        --   "docker-compose.yml",
        --   "lazygit",
        --   "GitHub Action",
        --   "GitHub Workflow",
        --   "GitHub Workflow Template Properties",
        --   "GitHub Issue Template forms",
        --   ".pre-commit-hooks.yml",
        --   "Netlify config",
        -- },

        -- additional schemas (not in the catalog)
        extra = {
          {
            description = "ast-grep configuration file",
            name = "ast-grep",
            url = "https://raw.githubusercontent.com/ast-grep/ast-grep/main/schemas/project.json",
            fileMatch = { "sgconfig.yml" },
          },
          {
            description = "ast-grep rule file",
            name = "ast-grep",
            url = "https://raw.githubusercontent.com/ast-grep/ast-grep/main/schemas/rule.json",
            fileMatch = { "**/.sg/rules/*.yml", "**/.sg/rules/**/*.yml" },
          },
        },
      }),
    },
  },
}