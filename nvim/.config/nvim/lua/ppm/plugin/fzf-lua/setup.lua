local u = require("ppm.utils")
local k = require("ppm.keymaps")

u.nquickmap(k.search.buffer, [[<cmd>FzfLua buffers<CR>]])
u.nquickmap(k.search.file_all,
  function() require("fzf-lua").files({ fd_opts = "--unrestricted --color=never --type f" }) end)
u.nquickmap(k.search.file, [[<cmd>FzfLua files<CR>]])
u.nquickmap(k.search.file_cwd, [[<cmd>FzfLua files cwd=%:p:h<CR>]])
u.nquickmap(k.search.git_file, [[<cmd>FzfLua git_files<CR>]])
u.nquickmap(k.search.grep, [[<cmd>FzfLua live_grep_glob<CR>]])
u.nquickmap(k.search.grep_cursor, [[<cmd>FzfLua grep_cword<CR>]])
u.nquickmap(k.search.help_tags, [[<cmd>FzfLua help_tags<CR>]])
u.nquickmap(k.search.oldfile, [[<cmd>FzfLua oldfiles<CR>]])
u.nquickmap(k.search.resume, [[<cmd>FzfLua resume<CR>]])

vim.keymap.set("i", "<C-x><C-f>", function() require("fzf-lua").complete_file() end,
  { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set("i", "<C-x>:",
  function() require("ppm.plugin.fzf-lua.providers.nerd-fonts").complete_symbol() end,
  { silent = true, desc = "Fuzzy complete Nerd Fonts symbol" })

vim.keymap.set({ "n", "v" }, "<leader>:", function() require("ppm.plugin.fzf-lua.providers.nerd-fonts").symbol() end,
  { silent = true, desc = "Fuzzy find Nerd Fonts symbol" })