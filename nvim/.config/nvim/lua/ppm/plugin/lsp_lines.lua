require("lsp_lines").setup()

vim.diagnostic.config({
  virtual_lines = { only_current_line = true, highighlight_whole_line = false },
  virtual_text = false,
})
