local u = require("ppm.utils")

require("typescript").setup({
  server = {
    on_attach = function(client, bufnr)
      u.buf_map(bufnr, "n", "go", ":TypescriptOrganizeImports<CR>")
    end,
  },
})
