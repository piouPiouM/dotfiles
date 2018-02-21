let php_sql_query          = 0
let php_sql_heredoc        = 0
let php_html_load          = 1
let php_html_in_strings    = 0
let php_html_in_heredoc    = 0
let php_parent_error_close = 0
let php_parent_error_open  = 0
let php_no_shorttags       = 1
let php_folding            = 0

setlocal tabstop=2 shiftwidth=2 softtabstop=2
setlocal expandtab

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>

