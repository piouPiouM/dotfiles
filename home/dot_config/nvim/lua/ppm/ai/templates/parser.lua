local E = require('ppm.toolkit.fp.Either')
local F = require('ppm.toolkit.fp.function')
local fmt = require('ppm.toolkit.frontmatter')
local process = require('ppm.ai.templates.process')

local pipe = F.pipe
local M = {}

---@param filepath string
---@return Frontmatter.Result|nil
M.parse = function(filepath)
  local template = fmt.parse_file(filepath)

  return pipe(
    template,
    E.map(process.extends),
    E.getOrElse(function(err)
      vim.notify('Error parsing template: ' .. err)

      return template
    end),
    E.toNullable
  )
end

return M