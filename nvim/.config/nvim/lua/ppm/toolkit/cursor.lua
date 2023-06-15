local fn = vim.fn

local M = {}

--- Get the character after the cursor.
--- @return string
function M.get_next_char()
  local next_col = fn.col(".")

  return fn.getline("."):sub(next_col, next_col)
end

--- Get the character before the cursor.
--- @return string
function M.get_prev_char()
  local prev_col = fn.col(".") - 1

  return fn.getline("."):sub(prev_col, prev_col)
end

--- @return boolean
function M.next_char(char) return M.get_next_char() == char end

--- @return boolean
function M.prev_char(char) return M.get_prev_char() == char end

--- Get the word before the cursor.
--- @return string
function M.get_previous_word()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(1, col):match("[^%s%p]*$")
end

--- Checks the presence of a word before the cursor position.
--- @return boolean
function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return M
