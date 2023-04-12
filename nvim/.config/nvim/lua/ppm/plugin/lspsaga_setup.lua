local k = require("ppm.keymaps")
local u = require("ppm.utils")

u.nquickmap(k.lsp.codeaction, [[<cmd>Lspsaga code_action<cr>]])
u.vquickmap(k.lsp.codeaction, [[<cmd><C-U>Lspsaga range_code_action<cr>]])
u.nquickmap(k.lsp.definition, [[<cmd>Lspsaga peek_definition<cr>]])
u.nquickmap(k.lsp.hover_doc, [[<cmd>Lspsaga hover_doc<cr>]]) -- filetype: sagahover
u.nquickmap(k.lsp.outline, [[<cmd>Lpsaga outline<cr>]])
u.nquickmap(k.lsp.rename, [[<cmd>Lspsaga rename ++project<cr>]])
u.nquickmap(k.lsp.search, [[<cmd>Lspsaga lsp_finder<cr>]])
u.nquickmap(k.lsp.diagnostic.cursor, [[<cmd>Lspsaga show_cursor_diagnostics<cr>]])
u.nquickmap(k.lsp.diagnostic.line, [[<cmd>Lspsaga show_line_diagnostics<cr>]])
