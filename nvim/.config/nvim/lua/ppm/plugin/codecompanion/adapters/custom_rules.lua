local rules = require("ppm.plugin.codecompanion.adapters.rules")

---@class CopilotWithCustomRules.Adapter: CodeCompanion.Adapter
local M = {
  name = "copilot_custom_rules",
  formatted_name = "Copilot CR",
  handlers = {
    form_messages = function(self, messages)
      if not vim.g.enable_codecompanion_custom_messages then
        return {
          messages = rules.remove_messages(messages),
        }
      end

      local obj = require("codecompanion.adapters.copilot").handlers.form_messages(self, messages)
      -- local _messages = rules.add_messages(obj.messages)
      local final_messages = rules.add_messages(obj.messages)

      return {
        messages = final_messages,
        -- messages = rules.add_buffers_message(_messages, adapter),
      }
    end,
  },
  schema = {
    model = {
      default = "claude-3.5-sonnet",
    },
    max_tokens = {
      default = 8192,
    },
  },
}

return require("codecompanion.adapters").extend("copilot", M)