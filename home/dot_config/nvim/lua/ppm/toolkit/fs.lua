local async = require("plenary.async")
local E = require("ppm.toolkit.fp.Either")

local M = {}

---@param filename string
---@return Either<string, string>
M.read_file_1 = function(filename)
  P({ filename = filename })
  local fd = vim.loop.fs_open(filename, "r", 420)

  if not fd then
    return E.left(string.format("File `%s` not found.", filename))
  end

  local stat = vim.loop.fs_fstat(fd)
  local content = vim.loop.fs_read(fd, stat.size)

  vim.loop.fs_close(fd)
  -- async.util.scheduler()

  return E.right(content)
end

---@generic T : string
---@param filepath T
---@return Either<string, T>
M.read_file = function(filepath)
  local err, fd = async.uv.fs_open(filepath, "r", 420)
  if err then
    return E.left(err)
  end

  local err, stat = async.uv.fs_fstat(fd)
  if err then
    return E.left(err)
  end

  local err, data = async.uv.fs_read(fd, stat.size, 0)
  if err then
    return E.left(err)
  end

  local err = async.uv.fs_close(fd)
  if err then
    return E.left(err)
  end

  return E.right(data)
end

---@generic T : string
---@param filepath T
---@return Either<string, T>
M.no_go_up = function(filepath)
  return string.match(filepath, "%.%.") and E.left("Moving up the tree is forbidden.") or E.right(filepath)
end

return M
