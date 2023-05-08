-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
require("nvim-navic").setup({
  click = true,
  highlight = true,
  lsp = {
    auto_attach = true,
    preference = { "ls_lua", "tsserver", "jsonls" },
  }
})
