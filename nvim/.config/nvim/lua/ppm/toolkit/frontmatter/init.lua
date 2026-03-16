local log = require("ppm.toolkit.log").log
local A = require("ppm.toolkit.fp.Array")
local E = require("ppm.toolkit.fp.Either")
local F = require("ppm.toolkit.fp.function")
local O = require("ppm.toolkit.fp.Option")
local S = require("ppm.toolkit.fp.string")
local frontmatter_utils = require("ppm.toolkit.frontmatter.utils")
local fs = require("ppm.toolkit.fs")
local pipe = F.pipe

local Frontmatter = {}

--- Return an table with Frontmatter and content parsed.
---
---@param text string
---@return Either<string, Frontmatter.Result>
Frontmatter.parse = function(text)
  ---@type Frontmatter.Metadata
  local metadata = {}

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
      local e_parsed = frontmatter_utils.process_line(metadata, current_key, line)

      if E.is_left(e_parsed) then
        return e_parsed
      end

      local parsed = E.toNullable(e_parsed)
      if type(parsed) ~= "nil" then
        current_key = parsed.current_key
        metadata = parsed.metadata
      end
    end

    ::skip_line::
  end

  return E.right({
    metadata = metadata,
    content = #metadata > 0 and (content or text) or (string.len(content) > 0 and content or text)
  })
end

--- Return an table with Frontmatter and content parsed.
---
---@param filepath string File to read.
---@return Either<string, Frontmatter.Result>
Frontmatter.parse_file = function(filepath)
  return pipe(
    filepath,
    fs.no_go_up,
    E.map(fs.read_file),
    E.map(Frontmatter.parse)
  )
end

return Frontmatter