local md = require("ppm.toolkit.markdown")
local S = require("ppm.toolkit.string")

local M = {}

M.parse = function(content)
  local frontmatter = md.parse_frontmatter(content)

  if rawget(frontmatter.content, "rules") ~= nil then
    local rules_to_load = S.split("%s*,?%s+")(frontmatter.content.rules)
  end
end

return M
