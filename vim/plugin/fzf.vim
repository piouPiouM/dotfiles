let g:fzf_action = {
      \ 'ctrl-q': function('ppm#fzf#build_quickfix_list'),
      \ 'ctrl-x': 'split',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-o': 'silent !open',
      \ }

let g:fzf_tags_command = 'ctags'
let g:fzf_commits_log_options = "--graph --color=always --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ar)%Creset'"

" Lightweight UI
" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
      " \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Files with preview
command! -bang -nargs=? -complete=dir Files call ppm#fzf#files(<q-args>, <bang>0)

" Search "color" in vim files only:
"     :Rg color -tvim
"     :Rg -tvim color
command! -bang -nargs=* PPMRg call ppm#fzf#rg(<q-args>, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Search "fzf":
"     :Spotlight fzf
" Search filenames that contains "fzf":
"     :Spotlight -name fzf
command! -bang -nargs=1 Spotlight call ppm#fzf#spotlight(<q-args>, <bang>0)

command! -bang GModified call ppm#fzf#git_modified(<q-args>, <bang>0)

command! -nargs=* Directories call fzf#run(fzf#wrap({
      \ 'source': "$FZF_ALT_C_COMMAND <q-args>"
      \ }))

