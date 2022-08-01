local g = vim.g

g.localvimrc_name = {
  ".git/init.lua",
  ".local/init.lua",
  ".config/init.lua",
  ".git/vimrc",
  ".lvimrc",
  ".local.vimrc",
  ".config/vimrc",
}
g.localvimrc_ask = 1
g.localvimrc_persistent = 1
g.localvimrc_persistence_file = string.format("%s/site/localvimrc/persistent",
                                              vim.fn.stdpath("data"))
g.localvimrc_sandbox = 0
g.localvimrc_whitelist = {} -- See $HOME/.local/vimrc
