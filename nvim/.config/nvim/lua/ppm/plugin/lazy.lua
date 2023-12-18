local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local configuration = {
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
  },
  install = { colorscheme = { "github", "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "getscriptPlugin",
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(configuration)
