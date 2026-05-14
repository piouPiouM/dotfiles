local k = require("ppm.keymaps")
local u = require("ppm.utils")

vim.g.neo_tree_remove_legacy_commands = 1

u.nquickmap(k.search.tree_reveal, [[<cmd>Neotree dir=%:p:h:h reveal_file=%:p<cr>]])
u.nquickmap(k.search.tree_reveal_cursor, [[<cmd>Neotree reveal_file=<cfile> hidden<cr>]])