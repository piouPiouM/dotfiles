" Vim compatibility

call ppm#source('config/xdg.vim')

set ttyfast    " Speed up rendering in modern shells.

" UI
set display=lastline
set autoindent       " Always set autoindenting on.
set autoread         " Set to auto read when a file is changed from the outside

" Undo
set backspace=indent,eol,start " Backspace through everything in insert mode.
"set nowritebackup
"set noswapfile

" Search
set hlsearch   " Highlight search things
set incsearch  " Make search act like search in modern browsers

" Statusline
set laststatus=2 " Always show status line.

set wildmenu              " Show menu with possible tab completions.
set tags=./tags;,tags;/

