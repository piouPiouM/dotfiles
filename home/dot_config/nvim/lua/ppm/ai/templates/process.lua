local A = require('ppm.toolkit.fp.Array')
local E = require('ppm.toolkit.fp.Either')
local F = require('ppm.toolkit.fp.function')
local Mo = require('ppm.toolkit.fp.Monoid')
local O = require('ppm.toolkit.fp.Option')
local S = require('ppm.toolkit.fp.string')
local fmt = require('ppm.toolkit.frontmatter')
local rules = require('ppm.ai.templates.rules')

local pipe = F.pipe
local M = {}

local is_userland_extend = F.flow(S.starts_with("@user/"))
local is_testland_extend = F.flow(S.starts_with("@tests/"))

---@param name string
local load_extend = function(name)
  local path = is_userland_extend(name)
      and rules.get_global_path(name)
      or is_testland_extend(name)
      and rules.get_tests_path(name)
      or rules.get_project_path(name)

  return pipe(
    path,
    fmt.parse_file,
    E.map(M.extends)
  )
end

---@param name string
---@param template Template
---@return Either<string, Template>
local has_extend_type = F.curry(function(name, template)
  return rawget(template.frontmatter, name) ~= nil and E.of(template) or E.left("No extend type found: " .. name)
end)

---@param extend_type Template.ExtendType
---@param template Template
---@return Either<string, Template>
local load_extends = F.curry(function(extend_type, template)
  local extends = template.frontmatter[extend_type]

  local extends_content = pipe(
    extends,
    A.map(load_extend),
    A.map(E.map(function(extend)
      return extend.content
    end)),
    A.map(E.getOrElse(function() return "" end)),
    Mo.concat_all(S.get_glue_monoid("\n\n")),
    E.of
  )

  local args = extend_type == "before"
      and { extends_content, template.content }
      or { template.content, extends_content }

  return vim.tbl_extend("force", template, {
    content = string.format("%s\n\n%s", unpack(args))
  })

  -- Copilot:
  -- local extends = template.frontmatter[extend_type]
  --
  -- if not extends then
  --   return E.left("No extends found")
  -- end
  --
  -- local extend_names = S.split(extends, ",")
  -- local extend_contents = F.map(load_one_extend, extend_names)
  --
  -- return pipe(
  --   extend_contents,
  --   E.sequence,
  --   E.map(function(extends)
  --     return {
  --       content = F.reduce(function(acc, extend)
  --         return acc .. extend.content
  --       end, "", extends)
  --     }
  --   end)
  -- )
end)

---@param extend_type Template.ExtendType
---@param template Template
local process_extend = F.curry(function(extend_type, template)
  return pipe(
    template,
    has_extend_type(extend_type),
    E.map(load_extends(extend_type)),
    E.map(function(extend)
      local args = extend_type == "before"
          and { extend.content, template.content }
          or { template.content, extend.content }

      return vim.tbl_extend("force", template, {
        content = string.format("%s\n\n%s", unpack(args))
      })
    end)
  )
end)

---@param template Template
M.extends = function(template)
  return pipe(
    template,
    E.map(process_extend("before")),
    E.map(process_extend("after"))
  )
end

return M
