local A = require("ppm.toolkit.fp.Array")
local E = require("ppm.toolkit.fp.Either")
local F = require("ppm.toolkit.fp.function")
local O = require("ppm.toolkit.fp.Option")
local S = require("ppm.toolkit.fp.string")
local frontmatter_utils = require("ppm.toolkit.frontmatter.utils")
local fs = require("ppm.toolkit.fs")
local pipe = F.pipe

---@class FrontmatterResult
---@field frontmatter FrontmatterData?
---@field content string?

local Frontmatter = {}

--- Return an table with Frontmatter and content parsed.
---
---@param text string
---@return Either<string, FrontmatterResult>
Frontmatter.parse = function(text)
  ---@type FrontmatterData
  local frontmatter = {}

  ---@type string
  local content = ""

  local in_frontmatter = false

  ---@type Option<string>
  local current_key = O.none
  local lines = S.split("\n", { trimempty = false })(text)

  for linenum, line in ipairs(lines) do
    if line == "---" then
      in_frontmatter = not in_frontmatter

      if (not in_frontmatter) then
        content = pipe(
          lines,
          A.take_right(#lines - linenum),
          S.glue("\n"),
          S.trim_end("\n")
        ) --[[@as string]]
        break
      end

      goto skip_line
    end

    if in_frontmatter then
      local e_parsed = frontmatter_utils.process_line(frontmatter, current_key, line)

      if E.is_left(e_parsed) then
        return e_parsed
      end

      local parsed = E.toNullable(e_parsed)
      if type(parsed) ~= "nil" then
        current_key = parsed.current_key
        frontmatter = parsed.data
      end
    end

    ::skip_line::
  end

  return E.right({
    frontmatter = frontmatter,
    content = #frontmatter > 0 and (content or text) or (string.len(content) > 0 and content or text)
  })
end

--- Return an table with Frontmatter and content parsed.
---
---@param filepath string File to read.
---@return Either<string, FrontmatterResult>
Frontmatter.parse_file = function(filepath)
  local file = fs.read_file(filepath)

  return pipe(
    file,
    E.map(Frontmatter.parse),
    E.getOrElse(F.identity)
  )
end

return Frontmatter