require("codecompanion").setup({
  adapters = {
    http = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-sonnet-4.5",
            },
          },
        })
      end,
    },
    -- copilot_custom_rules = function()
    --   return require("ppm.plugin.codecompanion.adapters.custom_rules")
    -- end,
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
  memory = {
    opts = {
      chat = {
        enabled = true,
      },
    },
  },
  strategies = {
    chat = {
      -- adapter = "copilot_custom_rules",
      adapter = "copilot",
      model = "claude-sonnet-4.5",
      roles = {
        user = "󰗋 Mehdi"
      },
      opts= {
        completion_provider = "cmp",
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
        ["image"] = {
          opts = {
            dirs = { "~/Pictures/screenshots" },
          },
        },
        ["symbols"] = {
          opts = {
            provider = "fzf_lua",
          },
        },
      },
    },
    inline = { adapter = "copilot", model = "claude-sonnet-4.5" },
    agent = { adapter = "copilot", model = "claude-sonnet-4.5" },
  },
  prompt_library = vim.tbl_deep_extend("force",
    require("ppm.ai.prompts.code"),
    require("ppm.ai.prompts.react"),
    require("ppm.ai.prompts.text")
  ),
})
