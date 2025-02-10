local M = {}

M.parse_frontmatter = function(content)
  local frontmatter = {}
  local in_frontmatter = false
  local line_start = nil
  local line_end = nil

  for line_number, line in content:gmatch("[^\r\n]+") do
    if line:match("^---$") then
      in_frontmatter = not in_frontmatter

      if (in_frontmatter) then
        line_start = line_number
      else
        line_end = line_number
      end
    elseif in_frontmatter then
      local key, value = line:match("^(%w+):%s*(.*)$")

      if key and value then
        frontmatter[key] = value
      end
    end
  end

  return {
    content = frontmatter,
    line_start = line_start,
    line_end = line_end
  }
end

return M