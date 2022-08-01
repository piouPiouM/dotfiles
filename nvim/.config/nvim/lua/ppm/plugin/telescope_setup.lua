local u = require("ppm.utils")

u.nmap("<leader><leader>", [[<cmd>Telescope find_files cwd=%:p:h<cr>]],
       "Search files in current directory")
u.nmap("<leader>e", [[<cmd>Telescope file_browser<cr>]], "Browe files")
u.nmap("<leader>f", [[<cmd>Telescope live_grep_args<cr>]], "Live grep")
u.nmap("<leader>b", [[<cmd>Telescope buffers<cr>]], "Search buffer")
u.nmap("<leader>m", [[<cmd>Telescope oldfiles<cr>]], "Recent files")
u.nmap("<leader>p", [[<cmd>Telescope find_files<cr>]], "Search files")
u.nmap("<leader>g", [[<cmd>Telescope git_files<cr>]], "Search files in git repository")
u.nmap("<leader>r", [[<cmd>Telescope resume<cr>]], "Resume Telescope")
u.nmap("<leader>w", [[<cmd>Telescope grep_string<cr>]], "Search word under the cursor")
u.nmap("<leader>H", [[<cmd>Telescope help_tags<cr>]], "Display help tags")
