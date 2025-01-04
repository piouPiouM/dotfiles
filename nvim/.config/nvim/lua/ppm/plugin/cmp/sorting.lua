local compare = require('cmp.config.compare')
local pkind = require("ppm.plugin.cmp.kind")

local function vscode(entry1, entry2)
  return pkind.get_vscode_score(entry1:get_kind()) < pkind.get_vscode_score(entry2:get_kind())
end

local M = {
  comparators = {
    require("copilot_cmp.comparators").prioritize,
    compare.recently_used,
    compare.exact,
    compare.score,
    compare.offset,
    -- compare.scopes,
    compare.locality,
    vscode,
    -- compare.kind,
    -- compare.sort_text,
    compare.length,
    compare.order,
  }
}

return M