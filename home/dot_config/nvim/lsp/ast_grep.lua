local util = require("lspconfig.util")

return {
  default_config = {
    cmd = { "ast-grep", "lsp" },
    single_file_support = false,
    root_dir = util.root_pattern("sgconfig.yml"),
  },
}