" commands.vim

" CDC = Change to Directory of Current file.
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
command! CDC cd %:p:h

" Delete all buffers but the active one.
command! BufOnly silent! w | %bd | e#
