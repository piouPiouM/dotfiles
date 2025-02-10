local M = {}

local condition = function(context)
  return context.filetype == "javascriptreact" or context.filetype == "typescriptreact"
end

M["RTL tests"] = {
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
  },
  references = {
    {
      type = "file",
      path = "lua/ppm/ai/prompts/rules/react-testing-library.md",
    }
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
    }
  },
}

return M
