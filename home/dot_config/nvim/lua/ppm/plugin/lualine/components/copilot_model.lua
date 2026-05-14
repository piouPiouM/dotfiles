local M = require("lualine.component"):extend()

local function get_copilot_model_name()
  local status_ok, copilot_util = pcall(require, 'copilot.client.utils')

  if not status_ok then
    return nil
  end

  local configs = copilot_util.get_workspace_configurations()
  if configs then
    ---@diagnostic disable-next-line: undefined-field
    return configs.settings.github.copilot.selectedCompletionModel
  end

  return nil
end

function M:init(options)
  M.super.init(self, options)

  local group = vim.api.nvim_create_augroup("CopilotModelHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CopilotModelChanged",
    group = group,
    callback = function()
      self:update_status()
    end,
  })
end

function M:update_status()
  local status_ok, copilot_lualine = pcall(require, 'copilot-lualine')
  if not status_ok or not copilot_lualine.is_enabled() then
    return
  end

  local model_name = get_copilot_model_name()

  if model_name ~= "" then
    return model_name
  else
    return "gpt-41-copilot"
  end
end

return M
