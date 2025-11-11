local plsp = require("ppm.lsp")

return {
  on_attach = function(client, bufnr)
    if client.name ~= "eslint" then return end

    plsp.event.format("LspEslintFixAll", client, bufnr)
  end,
}