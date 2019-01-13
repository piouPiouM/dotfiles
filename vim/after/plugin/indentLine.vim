if !exists("indentLine_loaded")
  finish
endif

let g:indentLine_char = "│"
let g:indentLine_fileTypeExclude = ["markdown", "json", "help"]
let g:indentLine_bufNameExclude = ["NERD_tree.*", "startify", "fzf", "vim-plug"]

