local k = require("ppm.keymaps")
local u = require("ppm.utils")

u.nquickmap(k.search.tree_reveal, [[<cmd>Neotree dir=%:p:h:h reveal_file=%:p<cr>]])
u.nquickmap(k.search.tree_reveal_cursor, [[<cmd>Neotree reveal_file=<cfile> hidden<cr>]])
