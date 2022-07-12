local g = vim.g

g.netrw_home = vim.fn.stdpath("cache")
g.netrw_liststyle = 3 -- Tree view
g.netrw_banner = 0 -- Type I to toggle banner
g.netrw_list_hide = vim.api.nvim_get_option("wildignore")
