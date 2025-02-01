require("codecompanion").setup({
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-3.5-sonnet",
          },
        },
      })
    end,
  },
  display = {
    chat = {
      show_header_separator = true,
    },
  },
  strategies = {
    chat = {
      adapter = "copilot",
      slash_commands = {
        ["buffer"] = {
          opts = {
            provider = "fzf_lua",
          },
        },
        ["file"] = {
          opts = {
            provider = "fzf_lua",
          },
        },
      },
    },
    inline = { adapter = "copilot" },
    agent = { adapter = "copilot" },
  },
  prompt_library = {
    ["Naming"] = {
      strategy = "inline",
      description = "Give betting naming for the provided code snippet.",
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

            return "Please provide better names for the following variables and functions:\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
  },
})
