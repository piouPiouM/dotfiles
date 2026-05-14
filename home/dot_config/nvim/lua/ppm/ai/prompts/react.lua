local M = {}

local condition = function(context)
  return context.filetype == "javascriptreact" or context.filetype == "typescriptreact"
end

-- Idée: utiliser treesitter pour parser le markdown afin de détecter
-- * frontmatter
-- * rôles
-- local log = require("ppm.toolkit.log").log
-- local frontmatter = require("ppm.toolkit.frontmatter")
-- local rules_path = vim.g.ppm_ai_path .. "/prompts/react-testing-library.md";
--
-- if vim.fn.filereadable(rules_path) == 1 then
--   local content = vim.fn.readfile(rules_path)
--   local parsed = frontmatter.parse(table.concat(content, "\n"))
--   P(parsed)
-- end


M["React Testing Library tests"] = {
  strategy = "chat",
  description = "Write integration tests for the following React component.",
  condition,
  opts = {
    index = 1,
    modes = { "n" },
    is_slash_cmd = true,
    short_name = "rtl",
    auto_submit = true,
    user_prompt = true,
    stop_context_insertion = false,
    default_memory = { "default", "react" },
  },
  context = {
    {
      type = "file",
      path = vim.g.ppm_ai_path .. "/rules/react.md",
    },
  },
  prompts = {
    {
      role = "system",
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      opts = {
        contains_code = true,
      },
    },
  },
}

return M