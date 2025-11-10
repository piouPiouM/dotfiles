local A = require("ppm.toolkit.fp.Array")
local E = require("ppm.toolkit.fp.Either")
local O = require("ppm.toolkit.fp.Option")
local F = require("ppm.toolkit.fp.function")
local S = require("ppm.toolkit.fp.string")
local pk = require("ppm.toolkit.primitive")
local pipe = F.pipe

---@generic D : Frontmatter.Metadata
---@generic K : Option<string>
---@class LineParsed<K,D>: { current_key: K, metadata: D }

---@param value string
---@return Frontmatter.Data
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

---@param metadata Frontmatter.Metadata
---@param key string
---@param item string
---@return Either<string, Frontmatter.Metadata>
local function handle_list_item(metadata, key, item)
  local new_value = parse_value(item)
  local current_value = metadata[key]
  local new_metadata = vim.tbl_extend("force", {}, metadata)

  if type(current_value) == "table" then
    if vim.tbl_contains(current_value, new_value) then
      return E.right(new_metadata)
    end

    new_metadata[key] = A.append(new_value)(current_value)

    return E.right(new_metadata)
  elseif type(current_value) == "nil" then
    new_metadata[key] = { new_value }

    return E.right(new_metadata)
  end

  return E.left("Invalid list syntax.")
end

---@param line string
---@return Option<string>
local function parse_list_item(line)
  local match = line:match("^%s*-%s*(.+)$")

  return match and O.some(match) or O.none
end

---@param metadata Frontmatter.Metadata
---@param key string
---@param value string
---@return Either<string, Frontmatter.Metadata>
local function handle_line_with_value(metadata, key, value)
  local parsed_value = parse_value(value)

  return E.right(vim.tbl_extend("force", metadata, { [key] = parsed_value }))
end

---@param line string
---@return Option<[string, string]>
local function parse_line(line)
  local key, value = line:match("([^:]+):%s*(.*)$")

  return key and O.some({ pk.trim(key), pk.trim(value) }) or O.none
end

---@generic A : Frontmatter.Metadata
---@generic B : Option<string>
---@param metadata A
---@param current_key B
---@param line string
---@return Either<string, LineParsed<B, A>>
local function process_line(metadata, current_key, line)
  local parsed_line = parse_line(line)
  local list_key = O.none

  if O.is_some(parsed_line) then
    local key, value = unpack(O.toNullable(parsed_line) or {})

    if S.trim()(value) == "" then
      list_key = O.some(key)

      return E.right({ current_key = list_key, metadata = metadata })
    end

    return pipe(
      handle_line_with_value(metadata, key, value),
      E.map(function(v)
        return { current_key = current_key, metadata = v }
      end)
    )
  end

  local parsed_list_item = parse_list_item(line)

  if O.is_some(parsed_list_item) then
    local item = O.toNullable(parsed_list_item)

    ---@diagnostic disable-next-line: return-type-mismatch
    return pipe(
      current_key,
      O.match(
        function()
          return E.left("List item without a key.")
        end,
        function(key)
          return pipe(
            handle_list_item(metadata, key, item),
            E.map(function(v)
              return { current_key = current_key, metadata = v }
            end)
          )
        end
      )
    )
  end

  return E.right({ current_key = current_key, metadata = metadata })
end

return {
  parse_value = parse_value,
  parse_line = parse_line,
  parse_list_item = parse_list_item,
  handle_line_with_value = handle_line_with_value,
  handle_list_item = handle_list_item,
  process_line = process_line,
}
