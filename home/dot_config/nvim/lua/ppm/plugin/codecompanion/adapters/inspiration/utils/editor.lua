-- Define the module table
local M = {}

-- Function to get buffer information
function M.get_buffers_info()
  local buffers_info = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(buffers) do
    if vim.fn.buflisted(bufnr) == 1 then
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local is_loaded = vim.api.nvim_buf_is_loaded(bufnr)
      local is_visible = false
      local winnr = nil

      if filename ~= "" and filename ~= nil then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == bufnr then
            is_visible = true
            winnr = vim.fn.win_id2win(win)
            break
          end
        end

        table.insert(buffers_info, {
          bufnr = bufnr,
          filename = filename,
          is_loaded = is_loaded,
          is_visible = is_visible,
          winnr = winnr
        })
      end
    end
  end

  return buffers_info
end

-- Function to generate system prompt for AI assistant
function M.generate_system_prompt()
  local buffers_info = M.get_buffers_info()
  local visible_buffers = {}
  local loaded_buffers = {}
  local unlisted_buffers = {}
  local unnamed_buffers = {}

  -- Categorize buffers
  for _, buf_info in ipairs(buffers_info) do
    if buf_info.is_visible then
      table.insert(visible_buffers, buf_info)
    elseif buf_info.is_loaded then
      table.insert(loaded_buffers, buf_info)
    end
  end

  -- Return nil if no buffers are found
  if #visible_buffers == 0 and #loaded_buffers == 0 then
    return nil
  end

  -- Initialize prompt
  local prompt =
  "The following buffers are currently active for the user. This list will always be up-to-date and any response that requires a reference to the active files should depend on this.\n\n"

  -- Add visible buffers section
  if #visible_buffers > 0 then
    prompt = prompt .. "### Visible Buffers:\n\nThese buffers are currently visible to the user:\n\n"
    for _, buf_info in ipairs(visible_buffers) do
      prompt = prompt ..
          string.format("Buffer ID: %d\nName: %s\nFiletype: %s\nPath: %s\nWinnr: %d\n\n", buf_info.bufnr,
            vim.fn.fnamemodify(buf_info.filename, ":t"), vim.bo[buf_info.bufnr].filetype, buf_info.filename,
            buf_info.winnr)
    end
  end

  -- Add loaded buffers section
  if #loaded_buffers > 0 then
    prompt = prompt .. "### Loaded Buffers:\n\nThese buffers are currently loaded but not visible:\n\n"
    for _, buf_info in ipairs(loaded_buffers) do
      prompt = prompt ..
          string.format("Buffer ID: %d\nName: %s\nFiletype: %s\nPath: %s\n\n", buf_info.bufnr,
            vim.fn.fnamemodify(buf_info.filename, ":t"), vim.bo[buf_info.bufnr].filetype, buf_info.filename)
    end
  end

  return prompt
end

-- Function to get lines with line numbers
function M.get_lines_with_numbers(bufnr, range)
  local start_line = range[1] or 0
  local end_line = range[2] or -1
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  local numbered_lines = {}

  for i, line in ipairs(lines) do
    table.insert(numbered_lines, string.format("%d: %s", start_line + i - 1, line))
  end

  local filetype = vim.bo[bufnr].filetype
  return string.format("```%s\n%s\n```", filetype, table.concat(numbered_lines, "\n"))
end

-- print(M.get_lines_with_numbers(0, { 1, -1 }))
-- print(M.generate_system_prompt())
-- Return the module table
return M