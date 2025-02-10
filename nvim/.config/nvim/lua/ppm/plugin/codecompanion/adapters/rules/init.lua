local pk_table = require("ppm.toolkit.table")
local F = require("ppm.toolkit.fp.function")
local pipe = F.pipe

local M = {}

local function get_tag(type, name)
  return string.format("custom_message_%s_%s", type, name)
end

local function get_global_rules(name)
  local rules_path = string.format(
    "%s/ai/rules/%s.md",
    vim.fn.fnamemodify(vim.fn.stdpath("data"), ":h"),
    name or "global"
  )

  if vim.fn.filereadable(rules_path) == 1 then
    vim.notify("Found global rules at " .. rules_path)

    return vim.fn.readfile(rules_path)
  end

  return nil
end

--- Search for project's rules.
local function get_project_rules(name)
  local path = vim.fn.getcwd()

  while path ~= "/" do
    local rules_path = string.format("%s/.ai/%s.md", path, name or "instructions")

    if vim.fn.filereadable(rules_path) == 1 then
      vim.notify("Found project instructions at " .. rules_path)

      return vim.fn.readfile(rules_path)
    end

    path = vim.fn.fnamemodify(path, ":h")
  end

  return nil
end

local function get_system_prompt(tag, rules)
  vim.notify("Adding system prompt with tag " .. tag)

  return {
    role = "system",
    content = table.concat(rules, "\n"),
    opts = {
      tag = tag,
      visible = false,
    }
  }
end

local function insert_message(scope, name)
  return function(messages)
    local rules = M.get_rules(scope, name)

    if not rules then
      return messages
    end

    local tag = get_tag(scope, name)
    local message_index = pk_table.find_index(messages, function(m)
      return m.opts and m.opts.tag == tag
    end)

    if message_index == -1 then
      table.insert(messages, scope == "global" and 2 or 3, get_system_prompt(tag, rules))
    else
      messages[message_index] = get_system_prompt(tag, rules)
    end

    return messages
  end
end

M.get_rules = function(scope, name)
  if scope == "global" then
    return get_global_rules(name or "global") or {}
  end

  if scope == "project" then
    return get_project_rules(name) or {}
  end

  return nil
end

M.remove_messages = function(messages)
  return vim.tbl_filter(function(message)
    return not (message.opts and message.opts.tag and message.opts.tag:find("custom_message_"))
  end, messages)
end

M.add_messages = function(messages)
  return pipe(
    messages,
    insert_message("global", "global"),
    insert_message("project", "instructions")
  )
end

-- M.add_buffers_message = function(messages, chat)
--   local bufs_message_index = pk_table.find_index(messages, function(message)
--     return message.opts and message.opts.tag == tags.CUSTOM_BUFFERS_MESSAGE
--   end)
--
--   local msg = get_buffers_message(chat)
--
--   if bufs_message_index == -1 then
--     table.insert(messages, 3, msg)
--   else
--     --replace with new message
--     messages[bufs_message_index] = msg
--   end
--
--   return messages
-- end

return M