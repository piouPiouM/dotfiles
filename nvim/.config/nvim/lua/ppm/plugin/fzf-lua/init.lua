local providers = require("ppm.plugin.fzf-lua.providers")

local config = {
  "telescope",
  global_git_icons = true,
  global_resume = true,
  global_resume_query = true,
  file_icon_padding = vim.env.TERM == "xterm-kitty" and " " or "",
  fzf_opts = { ["--no-separator"] = "" },
  winopts = { title = "", title_pos = "center" },
  previewers = {
    builtin = {
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["gif"] = { "viu", "-t" },
        ["jpg"] = { "viu", "-t" },
        ["png"] = { "viu", "-t" },
      },
    },
  },
  keymap = { builtin = { ["?"] = "toggle-preview" } },
}

require("fzf-lua").setup(vim.tbl_deep_extend("force", config, providers))
