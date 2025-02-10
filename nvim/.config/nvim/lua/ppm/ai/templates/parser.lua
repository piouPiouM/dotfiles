local M = {}

M.parse_frontmatter = function(content)
  local frontmatter = {}
  local in_frontmatter = false

  for line in content:gmatch("[^\r\n]+") do
    if line:match("^---$") then
      in_frontmatter = not in_frontmatter
    elseif in_frontmatter then
      local key, value = line:match("^(%w+):%s*(.*)$")
      if key and value then
        frontmatter[key] = value
      end
    end
  end

  return frontmatter
end

local function load_template(file, callback)
  vim.fs.readfile(file, { encoding = "utf-8" }, function(err, lines)
    if err then
      callback(nil, nil, err) -- Handle errors (nil parsed, nil frontmatter)
      return
    end

    local parsed = {}
    local frontmatter = {}
    local in_frontmatter = false

    for _, line in ipairs(lines) do
      if line == "---" then
        if in_frontmatter then
          in_frontmatter = false -- End of frontmatter
        else
          in_frontmatter = true  -- Start of frontmatter
        end
      elseif in_frontmatter then
        local key, value = line:match("([^:]+): (.+)")
        if key and value then
          frontmatter[key] = value
        end
      else
        local heading = line:match("^#+ (.*)")
        if heading then
          table.insert(parsed, { type = "heading", content = heading })
        else
          table.insert(parsed, { type = "text", content = line })
        end
      end
    end

    callback(parsed, frontmatter) -- Return parsed content and frontmatter
  end)
end

-- Example usage:
-- read_and_parse_markdown_async("/path/to/your/file.md", function(parsed, frontmatter, err)
--   if err then
--     print("Error: " .. err)
--   else
--     if frontmatter then
--         print("Frontmatter:")
--         for k, v in pairs(frontmatter) do
--             print(k .. ": " .. v)
--         end
--     end
--
--     print("\nParsed Content:")
--     for _, item in ipairs(parsed) do
--       print(item.type .. ": " .. item.content)
--     end
--
--   end
-- end)

--
-- -- Promise version
-- local function read_and_parse_markdown_async_promise(file)
--     return vim.Promise.new(function(resolve, reject)
--         read_and_parse_markdown_async(file, function(parsed, frontmatter, err)
--             if err then
--                 reject(err)
--             else
--                 resolve({parsed = parsed, frontmatter = frontmatter})
--             end
--         end)
--     end)
-- end
--
-- read_and_parse_markdown_async_promise("/path/to/your/file.md")
--     :then(function(result)
--         local parsed = result.parsed
--         local frontmatter = result.frontmatter
--
--         if frontmatter then
--             print("Frontmatter:")
--             for k, v in pairs(frontmatter) do
--                 print(k .. ": " .. v)
--             end
--         end
--
--         print("\nParsed Content:")
--         for _, item in ipairs(parsed) do
--             print(item.type .. ": " .. item.content)
--         end
--     end)
--     :catch(function(err)
--         print("Error: " .. err)
--     end)