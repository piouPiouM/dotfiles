local u = require("ppm.utils")

-- local keymaps = {
--   { mode = { "n", "v" }, target = "<C-a>", source = function() require("dial.map").inc_normal() end },

-- }

u.nmap("<C-a>", require("dial.map").inc_normal())
u.nmap("<C-x>", require("dial.map").dec_normal())
u.vmap("<C-a>", require("dial.map").inc_visual())
u.vmap("<C-x>", require("dial.map").dec_visual())
u.vmap("g<C-a>", require("dial.map").inc_gvisual())
u.vmap("g<C-x>", require("dial.map").dec_gvisual())

-- u.nmap("-", require("dial.map").inc_normal("case"))
-- u.nmap("_", require("dial.map").dec_normal("case"))
-- u.vmap("-", require("dial.map").inc_visual("case"))
-- u.vmap("_", require("dial.map").dec_visual("case"))

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = {"typescript", "javascript", "css", "scss", "sass" },
--   callback = u.buf_map(0, "n", "<C-a>", , desc: any)
-- })
