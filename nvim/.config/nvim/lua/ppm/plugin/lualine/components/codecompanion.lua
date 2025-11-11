local M = require("lualine.component"):extend()

local spinner_symbols = require("ppm.ui").spinners.robot

-- Initializer
function M:init(options)
  M.super.init(self, options)

  self.n_requests = 0
  self.spinner_index = 1


  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        self.n_requests = self.n_requests + 1
      elseif request.match == "CodeCompanionRequestFinished" then
        self.n_requests = self.n_requests - 1
      end
    end,
  })
end

-- Function that runs every time statusline is updated
function M:update_status()
  if self.n_requests > 0 then
    self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
    return ("%s%d"):format(spinner_symbols[self.spinner_index], self.n_requests)
  else
    return nil
  end
end

return M