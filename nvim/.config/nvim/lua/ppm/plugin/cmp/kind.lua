local cik = require('codicons.extensions.completion_item_kind')
local M = {}

M.get_vscode_score = function(kind)
  local to_search = type(kind) == "number" and vim.lsp.protocol.CompletionItemKind[kind] or kind

  return cik.symbols[to_search].index.vscode
end

M.get_icon = function(kind)
  local codicon = require("codicons")
  local icon_name = cik.symbols[kind] ~= nil and cik.symbols[kind].icon or 'symbol-misc'
  local icon = kind:lower() == "copilot" and "" or codicon.get(icon_name:lower(), 'icon')

  return string.format("%s ", icon)
end

M.is = function(name, kind)
  return vim.lsp.protocol.CompletionItemKind[name] == kind
end

return M