local M = {}

-- Thx to https://github.com/folke/lua-dev.nvim/blob/a0ee77789d9948adce64d98700cc90cecaef88d5/lua/lua-dev/sumneko.lua#L43-L54
M.path = function()
  local path = {}
  table.insert(path, "?.lua")
  table.insert(path, "?/init.lua")

  return path
end

M.name = 'sumneko_lua'
M.config = {
  -- not working 🤔
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end,

  cmd = {"lua-language-server"},
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = M.path() },
      completion = {callSnippet = "Replace"},
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      hint = {enable = true},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true)
      },
      telemetry = {enable = false}
    }
  }
}

return M
