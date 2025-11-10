local utils = require("user.utils") -- FIXME
local BufVariable = require("ppm.plugin.codecompanion.variables.buffers")

local function get_buffers_message(chat)
  local var = BufVariable.new({ layers = 2, chat = chat })
  local buf_message = var:execute()
  local prompt =
  "The following buffers are currently active for the user. This list will always be up-to-date and any response that requires line numbers and file content should depend on this.\n\n"

  return {
    role = "system",
    content = prompt .. "\n" .. buf_message,
    opts = {
      tag = "custom_buffers_message",
      visible = false,
    }
  }
end

local remove_custom_messages = function(messages)
  vim.notify("Removing custom messages")

  return vim.tbl_filter(function(message)
    return not (message.opts and message.opts.tag and message.opts.tag:find("custom_"))
  end, messages)
end

local add_buffers_message = function(messages, chat)
  local bufs_message_index = utils.find_index(messages, function(message)
    return message.opts and message.opts.tag == "custom_buffers_message"
  end)

  local msg = get_buffers_message(chat)

  if bufs_message_index == -1 then
    table.insert(messages, 3, msg)
  else
    --replace with new message
    messages[bufs_message_index] = msg
  end

  return messages
end

local function get_custom_instructions()
  local path = vim.fn.getcwd()

  while path ~= "/" do
    local instructions_path = path .. "/.github/copilot-instructions.md"

    if vim.fn.filereadable(instructions_path) == 1 then
      vim.notify("Found custom instructions at " .. instructions_path)

      return vim.fn.readfile(instructions_path)
    end

    path = vim.fn.fnamemodify(path, ":h")
  end

  return nil
end

local function get_custom_instructions_message()
  local instructions = get_custom_instructions()

  if instructions then
    local prompt = "User's Custom instructions for the current repository:\n\n"

    return {
      role = "system",
      content = prompt .. table.concat(instructions, "\n"),
      opts = {
        tag = "custom_instructions_message",
        visible = false,
      }
    }
  end

  return nil
end

local function add_custom_instructions_message(messages)
  local instructions_message_index = utils.find_index(messages, function(message)
    return message.opts and message.opts.tag == "custom_instructions_message"
  end)

  local msg = get_custom_instructions_message()

  if msg then
    if instructions_message_index == -1 then
      table.insert(messages, 2, msg)
    else
      messages[instructions_message_index] = msg
    end
  end

  return messages
end

return {
  add_buffers_message = add_buffers_message,
  get_buffers_message = get_buffers_message,
  add_custom_instructions_message = add_custom_instructions_message,
  get_custom_instructions_message = get_custom_instructions_message,
  remove_custom_messages = remove_custom_messages,
}
