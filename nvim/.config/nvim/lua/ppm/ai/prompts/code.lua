local M = {}

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

M["Naming"] = {
  strategy = "inline",
  description = "Give better naming for the provided code snippet.",
  opts = {
    index = 12,
    modes = { "v" },
    short_name = "naming",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return string.format([[
Please provide better names for the following variables and functions:

```%s
%s
```

]], context.filetype, code)
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}

M["Efficiency estimator"] = {
  strategy = "inline",
  description = "Calculate the time complexity of functions and algorithms.",
  opts = {
    index = 20,
    modes = { "v" },
    short_name = "complexity",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  propmts = {
    {
      role = "system",
      content =
      "Your task is to analyze the provided function or algorithm and calculate its time complexity using Big O notation. Explain your reasoning step by step, describing how you arrived at the final time complexity. Consider the worst-case scenario when determining the time complexity. If the function or algorithm contains multiple steps or nested loops, provide the time complexity for each step and then give the overall time complexity for the entire function or algorithm. Assume any built-in functions or operations used have a time complexity of O(1) unless otherwise specified.",
    },
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return string.format("\n```%s\n%s\n```\n", context.filetype, code)
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}

return M