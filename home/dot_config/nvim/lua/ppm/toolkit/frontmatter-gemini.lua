-- frontmatter.lua

local Frontmatter = {}

--- Trims leading and trailing whitespace from a string.
local function trim(str)
  return str:gsub("^%s*", ""):gsub("%s*$", "")
end

--- Parses a YAML value string into its Lua representation.
local function parse_value(value_string)
  local value = trim(value_string)
  if value:match("^%[%s*%]$") then return {} end
  if value:match("^%{%s*%}$") then return {} end
  if value:match("^%d+$") then return tonumber(value) end
  if value:match("^%d+%.%d+$") then return tonumber(value) end
  if value == "true" then return true end
  if value == "false" then return false end

  return value
end


--- Parses a YAML frontmatter string.
function Frontmatter.parse(frontmatter_string)
  local data = {}
  local lines = frontmatter_string:gmatch("[^\r\n]+")()

  local in_frontmatter = false
  local current_key = nil
  local in_list = false

  for _, line in ipairs(lines) do
    line = trim(line)

    if line == "---" then
      if not in_frontmatter then
        in_frontmatter = true
      else
        in_frontmatter = false
        break
      end
    elseif in_frontmatter then
      local key_match = line:match("([^:]+):")

      if key_match then
        current_key = trim(key_match)
        data[current_key] = data[current_key] or {}
        in_list = false
      elseif line:match("^%s*-%s") then -- List item
        if current_key then
          local value_string = line:match("^%s*-%s*(.+)")
          local value = parse_value(value_string)

          if type(data[current_key]) == "table" and not in_list then
            data[current_key] = { value }
            in_list = true
          elseif type(data[current_key]) == "table" and in_list then
            table.insert(data[current_key], value)
          else
            return nil, "Invalid list syntax"
          end
        else
          return nil, "List item without a key"
        end
      elseif current_key and not in_list and line ~= "" then -- Single-line value
        local value = parse_value(line)

        data[current_key] = value
      end
    end
  end

  if not in_frontmatter then
    return nil, "Frontmatter not found or malformed"
  end

  return data, nil
end

return Frontmatter
