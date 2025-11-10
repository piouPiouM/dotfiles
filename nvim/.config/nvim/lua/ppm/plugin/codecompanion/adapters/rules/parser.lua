local markdown = require("ppm.toolkit.markdown")
local A = require("ppm.toolkit.fp.Array")
local S = require("ppm.toolkit.fp.string")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

local M = {}

local function parse_extend(extend)
  return pipe(
    extend,
    S.split("%s*,?%s+"),
    A.map(function(raw_name)
      if S.starts_with("@user/")(raw_name) then
        return { scope = "global", name = S.replace_first("@user/", "") }
      end

      return { scope = "project", name = raw_name }
    end)
  )
end

M.parse = function(content)
  local frontmatter = markdown.parse_frontmatter(content)
  local rules_to_load = {
    before = rawget(frontmatter.content, "before") ~= nil and parse_extend(frontmatter.content.before) or nil,
    after = rawget(frontmatter.content, "after") ~= nil and parse_extend(frontmatter.content.after) or nil,
  }
end

return M