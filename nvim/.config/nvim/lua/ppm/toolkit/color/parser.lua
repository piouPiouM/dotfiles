-- local E = require("ppm.toolkit.fp.Either")
local S = require("ppm.toolkit.fp.string")

local remove_captures = function(pattern)
  return pattern
      :gsub("%%%(", "@open@")
      :gsub("%%%)", "@close@")
      :gsub("%(", "")
      :gsub("%)", "")
      :gsub("@open@", "%%(")
      :gsub("@close@", "%%)")
end

local Parser = {}
Parser.__index = Parser
-- local mt = {
--   __index = Parser,
-- }

---@param predicate fun(str: string): boolean
function Parser:of(predicate)
  assert(type(predicate) == "function", "predicate must be a function")

  local instance = {
    tag = "color.parser",
    _assert = predicate,
  }

  return setmetatable(instance, self)
end

---@param pattern string A Lua pattern.
function Parser:add(pattern)
  table.insert(self, pattern)

  return self
end

---@param options? { with_captures: boolean }
function Parser:all(options)
  local params = setmetatable(options or {}, { __index = { with_captures = true } })

  local stack = {}
  for index, pattern in ipairs(self) do
    stack[index] = params.with_captures and pattern or remove_captures(pattern)
  end

  return stack
end

function Parser:match(matcher)
  assert(type(matcher) == "function", "Given `matcher` must be a function.")
  self._matcher = matcher

  return self
end

function Parser:parse(str)
  for _, pattern in ipairs(self:all()) do
    local matches = { str:match(pattern) }
    if #matches > 0 then
      return self._matcher(matches, str)
    end
  end

  return nil
end

return Parser

--- ###############################################
--- ###############################################

--[[
local class = require("ppm.toolkit.class")
local converters = require("ppm.colors.converters")
local A = require("ppm.toolkit.fp.Array")
local S = require("ppm.toolkit.fp.string")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

local M = {}

local Parser = class(nil, function(this, assertFn, p)
  this._assert = assertFn
  this._patterns = p
  this._convert = F.identity
end)

Parser.remove_captures = function(pattern)
  return pattern
      :gsub("%%%(", "@open@")
      :gsub("%%%)", "@close@")
      :gsub("%(", "")
      :gsub("%)", "")
      :gsub("@open@", "%%(")
      :gsub("@close@", "%%)")
end

function Parser:valid(value)
  return self._assert(value) == true
end

function Parser:get_patterns()
  return vim.tbl_map(self.remove_captures, self._patterns)
end

function Parser:set_matcher(matcher)
  self._convert = matcher
end

---@param value string
function Parser:parse(value)
  for _, pattern in ipairs(self._patterns) do
    local matches = { value:match(pattern) }
    if #matches > 0 then
      return self._convert(matches, value)
    end
  end

  return nil
end

local normalize_alpha = function(alpha)
  if type(alpha) == "nil" then
    return 100
  end

  if alpha:match("%%$") then
    return alpha:gsub("%%", "")
  end

  return tonumber(alpha) * 100
end

local capture = function(str)
  return "(" .. str .. ")"
end

local modern_glue = S.glue("%s+")
local legacy_glue = S.glue(",%s*")

local patterns = {
  number = capture("%d+%.?%d*"),
  percentage = capture("%d+%.?%d*%%"),
  hex3 = "#%x%x%x%f[^%x%w]",           -- RGB
  hex4 = "#%x%x%x%x%f[^%x%w]",         -- RGBA
  hex6 = "#%x%x%x%x%x%x%f[^%x%w]",     -- RRGGGBB
  hex8 = "#%x%x%x%x%x%x%x%x%f[^%x%w]", -- RRGGGBBAA
}

patterns.alpha = {
  modern = "/%s*" .. patterns.percentage,
  legacy = patterns.number,
}

patterns.angle = {
  deg = patterns.number .. "deg",
  grad = patterns.number .. "grad",
  rad = patterns.number .. "rad",
  turn = patterns.number .. "turn",
}

local definitions = {
  hex = Parser(S.starts_with("#"), {
    patterns.hex3,
    patterns.hex4,
    patterns.hex6,
    patterns.hex8,
  }):set_matcher(function(full_match)
    local rgb = require("ppm.toolkit.color.converters.rgb")

    return rgb.from_hex(full_match)
  end),
  rgb = Parser(S.starts_with("rgba?"), {
    -- Modern syntax
    pipe({ patterns.number, patterns.number, patterns.number }, modern_glue, S.format("rgba?%%(%s%%)")),
    pipe({ patterns.number, patterns.number, patterns.number, patterns.alpha.modern }, modern_glue,
      S.format("rgba?%%(%s%%)")),
    -- Legacy syntax
    pipe({ patterns.number, patterns.number, patterns.number }, legacy_glue, S.format("rgba?%%(%s%%)")),
    pipe({ patterns.number, patterns.number, patterns.number, patterns.alpha.legacy }, legacy_glue,
      S.format("rgba?%%(%s%%)")),
  }):set_matcher(function(_, match)
    local red, green, blue, alpha = table.unpack(match)
  end),
  hsl = Parser(S.starts_with("hsla?"), {
    -- Modern syntax
    pipe({ patterns.number, patterns.percentage, patterns.percentage }, modern_glue, S.format("hsla?%%(%s%%)")),
    pipe({ patterns.angle.deg, patterns.percentage, patterns.percentage }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.grad, patterns.percentage, patterns.percentage }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.rad,  patterns.percentage, patterns.percentage }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.turn, patterns.percentage, patterns.percentage }, modern_glue, S.format("hsla?%%(%s%%)")),
    pipe({ patterns.number, patterns.percentage, patterns.percentage, patterns.alpha.modern }, modern_glue,
      S.format("hsla?%%(%s%%)")),
    pipe({ patterns.angle.deg, patterns.percentage, patterns.percentage, patterns.alpha.modern }, modern_glue,
      S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.grad, patterns.percentage, patterns.percentage, patterns.alpha.modern }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.rad,  patterns.percentage, patterns.percentage, patterns.alpha.modern }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.turn, patterns.percentage, patterns.percentage, patterns.alpha.modern }, modern_glue, S.format("hsla?%%(%s%%)")),
    -- Legacy syntax
    pipe({ patterns.number, patterns.percentage, patterns.percentage }, legacy_glue, S.format("hsla?%%(%s%%)")),
    pipe({ patterns.angle.deg, patterns.percentage, patterns.percentage }, legacy_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.grad, patterns.percentage, patterns.percentage }, legacy_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.rad,  patterns.percentage, patterns.percentage }, legacy_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.turn, patterns.percentage, patterns.percentage }, legacy_glue, S.format("hsla?%%(%s%%)")),
    pipe({ patterns.number, patterns.percentage, patterns.percentag, patterns.alpha.legacy }, legacy_glue,
      S.format("hsla?%%(%s%%)")),
    pipe({ patterns.angle.deg, patterns.percentage, patterns.percentag, patterns.alpha.legacy }, legacy_glue,
      S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.grad, patterns.percentage, patterns.percentag, patterns.alpha.legacy }, legacy_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.rad,  patterns.percentage, patterns.percentag, patterns.alpha.legacy }, legacy_glue, S.format("hsla?%%(%s%%)")),
    -- pipe({ patterns.angle.turn, patterns.percentage, patterns.percentag, patterns.alpha.legacy }, legacy_glue, S.format("hsla?%%(%s%%)")),
  }),
}
--   ---@param match [string, string, string, string?]
--   picker = function(match)
--     assert(match)
--     local nh, ns, nl, na = table.unpack(match)
--     local h, s, l, a = tonumber(nh), tonumber(ns), tonumber(nl), tonumber(na)
--
--     return { h, s, l, a }
--   end

M.parse = function(value)
  for type, parser in pairs(definitions) do
    if parser:valid(value) then
      return parser.parse(value), type
    end
  end
end

return M
]]