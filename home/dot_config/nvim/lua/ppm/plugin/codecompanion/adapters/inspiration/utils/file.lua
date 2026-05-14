local M = {}

--- Get the root directory based on the current file path and the specified number of layers
--- @param current_file_path string
--- @param layers number
--- @return string
function M.get_root_dir(current_file_path, layers)
  if not layers or layers == 0 then
    return current_file_path
  end

  local root_dir = current_file_path

  for _ = 1, layers do
    root_dir = vim.fn.fnamemodify(root_dir, ":h")
  end

  return root_dir
end

--- Generate the file structure up to the specified number of layers
--- @param root_dir string
--- @param layers number
--- @param ignore_dirs table
--- @return string
function M.generate_file_structure(root_dir, layers, ignore_dirs)
  local function is_ignored(name)
    for _, ignore in ipairs(ignore_dirs) do
      if name:match(ignore) then
        return true
      end
    end

    return false
  end

  local function get_sorted_entries(dir)
    local dirs = {}
    local files = {}
    local entries = vim.fn.readdir(dir)

    for _, entry in ipairs(entries) do
      if entry ~= "." and entry ~= ".." and not is_ignored(entry) then
        local full_path = dir .. "/" .. entry
        if vim.fn.isdirectory(full_path) == 1 then
          table.insert(dirs, entry)
        else
          table.insert(files, entry)
        end
      end
    end

    table.sort(dirs)
    table.sort(files)

    return dirs, files
  end

  local function scan_dir(dir, depth, prefix)
    if depth > layers then
      return ""
    end

    local result = {}
    local dirs, files = get_sorted_entries(dir)
    local total_entries = #dirs + #files
    local count = 0

    -- Process directories
    for index, directory in ipairs(dirs) do
      count = count + 1
      local is_last = (count == total_entries) and (#files == 0)
      local full_path = dir .. "/" .. directory
      local current_prefix = is_last and "└── " or "├── "
      local next_prefix = is_last and "    " or "│   "

      table.insert(result, prefix .. current_prefix .. directory)
      local sub_content = scan_dir(full_path, depth + 1, prefix .. next_prefix)
      if sub_content ~= "" then
        table.insert(result, sub_content)
      end
    end

    -- Process files
    for i, file in ipairs(files) do
      count = count + 1
      local is_last = (count == total_entries)
      local current_prefix = is_last and "└── " or "├── "
      table.insert(result, prefix .. current_prefix .. file)
    end

    return table.concat(result, "\n")
  end

  return scan_dir(root_dir, 1, "")
end

--- Check if a file exists and is readable
--- @param file_path string
--- @return boolean
function M.file_exists(file_path)
  local f = io.open(file_path, "r")

  if f then
    io.close(f)
    return true
  end
  return false
end

--- Get file size in bytes
--- @param file_path string
--- @return number|nil, string|nil
function M.get_file_size(file_path)
  if not M.file_exists(file_path) then
    return nil, "File does not exist"
  end

  local f = io.open(file_path, "r")

  if not f then
    return nil, "Cannot open file"
  end

  local size = f:seek("end")
  f:close()

  return size
end

--- Read file contents
--- @param file_path string
--- @return string|nil, string|nil
function M.read_file(file_path)
  if not M.file_exists(file_path) then
    return nil, "File does not exist"
  end

  local f = io.open(file_path, "r")

  if not f then
    return nil, "Cannot open file"
  end

  local content = f:read("*all")
  f:close()

  return content
end

--- List files in directory
--- @param dir_path string
--- @param pattern string|nil
--- @return table|nil, string|nil
function M.list_files(dir_path, pattern)
  pattern = pattern or ""
  local files = {}
  local handle = vim.loop.fs_scandir(dir_path)

  if not handle then
    return nil, "Cannot open directory"
  end

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)

    if not name then
      break
    end

    if type == "file" and (pattern == "" or name:match(pattern)) then
      table.insert(files, name)
    end
  end

  return files
end

return M
