local buf_utils = require("codecompanion.utils.buffers")
local file_utils = reload("ppm.plugin.codecompanion.utils.file")
local editor_utils = reload("user.utils.editor")

local Variable = {}

local function get_active_buf()
  local bufs = editor_utils.get_buffers_info()
  local active_buf = vim.tbl_filter(function(buf)
    return buf.is_visible
  end
  , bufs)[1]

  return active_buf
end

function Variable.new(args)
  local self = setmetatable({
    chat = args.chat,
    params = args.params,
    layers = args.layers or 1,
  }, { __index = Variable })

  return self
end

---Return the contents of all listed and loaded buffers
---@return string
function Variable:execute()
  local buffers_info = editor_utils.get_buffers_info()
  local output = {}

  -- First add visible buffers
  for _, buf_info in ipairs(buffers_info) do
    if buf_info.is_visible and vim.api.nvim_buf_is_loaded(buf_info.bufnr) then
      local buffer_content = buf_utils.format_with_line_numbers(buf_info.bufnr)
      buffer_content = "Visible Buffer:\n" .. buffer_content
      table.insert(output, buffer_content)
    end
  end

  -- Then add non-visible buffers
  for _, buf_info in ipairs(buffers_info) do
    if not buf_info.is_visible and vim.api.nvim_buf_is_loaded(buf_info.bufnr) then
      local buffer_content = buf_utils.format_with_line_numbers(buf_info.bufnr)
      table.insert(output, buffer_content)
    end
  end

  local active_buffers = table.concat(output, "\n\n")
  local file_structure = self:get_file_structure()

  return [[
=== Active Buffers ===

]] .. active_buffers .. [[

=== File Structure ]] .. self.layers .. [[ layers up ===

]] .. file_structure .. [[
  ]]
end

---Generate the file structure up to the specified number of layers
---@return string
function Variable:get_file_structure()
  local current_file_path = get_active_buf().filename
  local layers_up = self.layers
  local layers_deep = 3 -- Adjust as needed

  if self.params then
    local layersup, layersdown = self.params:match("(%d+)-(%d+)")

    if layersup and layersdown then
      layers_up = tonumber(layersup) or layers_up
      layers_deep = tonumber(layersdown) or layers_deep
    end
  end

  local ignore_dirs = { "^%.git$", "^node_modules$", "^.DS_Store$", "^__pycache__$" }
  local root_dir = file_utils.get_root_dir(current_file_path, layers_up)
  local file_structure = file_utils.generate_file_structure(root_dir, layers_deep, ignore_dirs)

  return [[
]] .. root_dir .. [[

]] .. file_structure .. [[
  ]]
end

return Variable