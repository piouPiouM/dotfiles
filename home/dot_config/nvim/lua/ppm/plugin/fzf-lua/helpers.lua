local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp")
local Mo = require("ppm.toolkit.fp.Monoid")
local O = require("ppm.toolkit.fp.Option")
local S = require("ppm.toolkit.fp.string")
local p = require("ppm.toolkit.primitive")
local pipe = F.pipe

local M = {}

--- Combines first words of each `selected` entry with `separator`.
---
---@param separator string
---@return fun(selected: string[]): string
M.join_first_words = function(separator)
  local gluer = O.get_monoid(S.get_glue_monoid(separator))

  return function(selected)
    return pipe(
      selected,
      A.map(p.first_word),
      A.append(O.some("")),
      Mo.concat_all(gluer),
      O.getOrElse(F.constant(""))
    ) --[[@as string]]
  end
end

M.exec = function(cmd, data)
  return function(opts)
    return O.try_catch(function()
      return cmd(data, opts)
    end)
  end
end

return M
