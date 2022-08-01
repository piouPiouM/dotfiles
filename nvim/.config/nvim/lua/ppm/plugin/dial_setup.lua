local u = require("ppm.utils")

-- local keymaps = {
--   { mode = { "n", "v" }, target = "<C-a>", source = function() require("dial.map").inc_normal() end },

-- }

u.nmap("<C-a>", "<Plug>(dial-increment)")
u.nmap("<C-x>", "<Plug>(dial-decrement)")
u.vmap("<C-a>", "<Plug>(dial-increment)")
u.vmap("<C-x>", "<Plug>(dial-decrement)")
u.vmap("g<C-a>", "g<Plug>(dial-increment)")
u.vmap("g<C-x>", "g<Plug>(dial-decrement)")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = {"typescript", "javascript", "css", "scss", "sass" },
--   callback = u.buf_map(0, "n", "<C-a>", , desc: any)
-- })
