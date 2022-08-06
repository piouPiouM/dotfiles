local u = require("ppm.utils")

-- u.nmap("<Localleader><Space>R", [[<cmd>Neotree reveal hidden<cr>]],
--        "Reveal current file in file browser")
u.nmap("<Localleader><Space>r", [[<cmd>Neotree dir=%:p:h:h reveal_file=%:p float<cr>]],
       "Reveal current file in file browser")
u.nmap("<Localleader><Space>c", [[<cmd>Neotree float reveal_file=<cfile> hidden<cr>]],
       "Reveal file under the cursor in file browser")
