require("codecompanion").setup({
  adapters = {
    copilot = function()
      -- return require("ppm.plugin.codecompanion.adapters.custom_rules")
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-3.5-sonnet",
          },
        },
      })
    end,
    copilot_custom_rules = function()
      return require("ppm.plugin.codecompanion.adapters.custom_rules")
    end,
  },
  display = {
    chat = {
      show_header_separator = true,
      start_in_insert_mode = true,
      icons = {
        pinned_buffer = " ",
        watched_buffer = "👀 ",
      },
      intro_message = "Ask to CodeCompanion   Press ? for options",
    },
  },
  strategies = {
    chat = {
      adapter = "copilot_custom_rules",
      roles = {
        user = "󰟶 Human"
      },
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
        ["help"] = {
          opts = {
            provider = "fzf_lua",
          },
        },
        ["symbols"] = {
          opts = {
            provider = "fzf_lua",
          },
        },
      },
    },
    inline = { adapter = "copilot" },
    agent = { adapter = "copilot" },
  },
  prompt_library = vim.tbl_deep_extend("force",
    require("ppm.ai.prompts.code"),
    require("ppm.ai.prompts.text")
  ),
})