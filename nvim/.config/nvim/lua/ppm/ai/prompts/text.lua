local M = {}

M["Mood colorizer"] = {
  strategy = "inline",
  description = "Transform text descriptions of moods into corresponding HEX codes.",
  opts = {
    modes = { "v" },
    short_name = "mood-colorizer",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
    ignore_system_prompt = true,
  },
  prompts = {
    {
      role = "system",
      content =
      [[Your task is to take the provided text description of a mood or emotion and generate a HEX color code that visually represents that mood.
Use color psychology principles and common associations to determine the most appropriate color for the given mood.
If the text description is unclear, ambiguous, or does not provide enough information to determine a suitable color, respond with “Unable to determine a HEX color code for the given mood.]],
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local selection = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return selection
      end,
    }
  }
}

M["Spelling"] = {
  strategy = "inline",
  description = "Transform grammatically incorrect sentences into proper English.",
  opts = {
    modes = { "v" },
    short_name = "spelling",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
    ignore_system_prompt = true,
  },
  prompts = {
    {
      role = "system",
      content =
      "Your task is to take the text provided and rewrite it into a clear, grammatically correct version while preserving the original meaning as closely as possible. Correct any spelling mistakes, punctuation errors, verb tense issues, word choice problems, and other grammatical mistakes.",
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local selection = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return selection
      end,
    }
  }
}

return M
