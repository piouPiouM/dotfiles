local providers = {
  "buffers",
  "complete",
  "files",
  "git",
  "grep",
  "nvim",
}

local M = {}

for _, provider in ipairs(providers) do
  M = vim.tbl_extend("force", M, require("ppm.plugin.fzf-lua.providers." .. provider))
end

return M