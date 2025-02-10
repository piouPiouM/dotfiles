local A = require("ppm.toolkit.fp.Array")
local E = require("ppm.toolkit.fp.Either")
local O = require("ppm.toolkit.fp.Option")
local F = require("ppm.toolkit.fp.function")
local S = require("ppm.toolkit.fp.string")
local pk = require("ppm.toolkit.primitive")
local pipe = F.pipe

---@alias FrontmatterMetadata string | string | number | boolean | table | string[]

---@alias FrontmatterData FrontmatterMetadata[]

---@generic A : FrontmatterData
---@generic B : Option<string>
---@class LineParsed<K,D>: { current_key: K, data: D }

---@param value string
---@return string | number | boolean | table | string[]
local function parse_value(value)
  local trimmed = pipe(value, S.trim())

  if trimmed:match("^%[%s*%]$") or trimmed:match("^%{%s*%}$") then
    return {}
  end

  if trimmed == "true" then return true end
  if trimmed == "false" then return false end

  local num = tonumber(trimmed)
  if num ~= nil then return num end

  return trimmed
end

---@param data FrontmatterData
---@param key string
---@param item string
---@return Either<string, FrontmatterData>
local function handle_list_item(data, key, item)
  local newValue = parse_value(item)
  local currentValue = data[key]
  local newData = vim.tbl_extend("force", {}, data)

  if type(currentValue) == "table" then
    if vim.tbl_contains(currentValue, newValue) then
      return E.right(newData)
    end

    newData[key] = A.append(newValue)(currentValue)

    return E.right(newData)
  elseif type(currentValue) == "nil" then
    newData[key] = { newValue }

    return E.right(newData)
  end

  return E.left("Invalid list syntax.")
end

---@param line string
---@return Option<string>
local function parse_list_item(line)
  local match = line:match("^%s*-%s*(.+)$")

  return match and O.some(match) or O.none
end

---@param data FrontmatterData
---@param key string
---@param value string
---@return Either<string, FrontmatterData>
local function handle_line_with_value(data, key, value)
  local parsedValue = parse_value(value)

  return E.right(vim.tbl_extend("force", data, { [key] = parsedValue }))
end

---@param line string
---@return Option<[string, string]>
local function parse_line(line)
  local key, value = line:match("([^:]+):%s*(.*)$")

  return key and O.some({ pk.trim(key), pk.trim(value) }) or O.none
end

---@generic A : FrontmatterData
---@generic B : Option<string>
---@param data B
---@param current_key B
---@param line string
---@return Either<string, LineParsed<B, A>>
local function process_line(data, current_key, line)
  local parsedLine = parse_line(line)
  local list_key = O.none

  if O.is_some(parsedLine) then
    local key, value = unpack(O.toNullable(parsedLine) or {})

    if S.trim()(value) == "" then
      list_key = O.some(key)

      return E.right({ current_key = list_key, data = data })
    end

    return pipe(
      handle_line_with_value(data, key, value),
      E.map(function(v)
        return { current_key = current_key, data = v }
      end)
    )
  end

  local parsedListItem = parse_list_item(line)

  if O.is_some(parsedListItem) then
    local item = O.toNullable(parsedListItem)

    ---@diagnostic disable-next-line: return-type-mismatch
    return pipe(
      current_key,
      O.match(
        function()
          return E.left("List item without a key.")
        end,
        function(key)
          return pipe(
            handle_list_item(data, key, item),
            E.map(function(v)
              return { current_key = current_key, data = v }
            end)
          )
        end
      )
    )
  end

  return E.right({ current_key = current_key, data = data })
end

return {
  parse_value = parse_value,
  parse_line = parse_line,
  parse_list_item = parse_list_item,
  handle_line_with_value = handle_line_with_value,
  handle_list_item = handle_list_item,
  process_line = process_line,
}