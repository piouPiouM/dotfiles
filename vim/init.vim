" .vimrc
" Author: Mehdi Kabab <http://pioupioum.fr>
" Source: http://github.com/piouPiouM/dotfiles/
"
" 1. Preamble
" 2. Bundles
" 3. Basic configuration
" 4. UI options
" 5. Text formatting

" Section: Preamble {{{1

set shell=zsh
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

let g:ppm_vim_path = escape(fnamemodify(resolve(expand("<sfile>:p" . "vim")), ":h"), ' ')

" Source core functions.
exe 'source ' . g:ppm_vim_path . '/config/ppm.vim'

if ! has('nvim')
  set nocompatible    " Vim motherfucker!
endif

" }}}1
" Section: Bundles {{{1

filetype off
source $XDG_CONFIG_HOME/nvim/config/vim-plug.vim
filetype plugin indent on

" }}}1
" Section: Basic configuration {{{1

syntax enable             " Turn on syntax highlighting.
set hidden                " Don't require saving before editing another file.

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif

" set Vim-specific sequences for RGB colors
" https://github.com/vim/vim/issues/993#issuecomment-255651605
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set mouse=a    " Enable mouse support.
set showmatch  " Show matching brackets/parenthesis
set modelines=0
set history=300
set lazyredraw " Do not redraw while running macros (much faster).
set nofsync    " Let the OS decide when it's appropriate to flush the cache, rather than vim (much faster).
set regexpengine=1

" used by gf to follow ES6 import - Ctrl-o to come back
set suffixesadd=.js,.jsx,.json,.ts,.styl,.css,.scss

if has('balloon_eval') && has('unix')
  set ballooneval
endif

" Undo {{{2

set noswapfile
if has('persistent_undo')
  set undofile
endif

" }}}2
" Search {{{2

set ignorecase " Ignore case when searching
set smartcase  " except if it's an uppercase search
set magic      " Set magic on, for regular expressions
set gdefault   " Apply global substitutions
set grepprg=rg\ --vimgrep

if has('nvim')
  set inccommand=nosplit
endif

" }}}2
" }}}1
" Section: UI options {{{1

set splitbelow splitright  " Split window at right bottom.
set number relativenumber  " Hybrid line numbers.
set nocursorline           " Disable current line highlighting.
set scrolloff=3            " Provide some context when editing.
set clipboard=unnamedplus
set guifont=FuraCode\ Nerd\ Font:12

if has('cmdline_info')
  set ruler                                          " Show the ruler.
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids.
  set showcmd                                        " Show partial commands in status line and
                                                     " selected characters/lines in visual mode.
endif

set list                       " Show invisible characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:․
set showbreak=↪

" - don't give the "ATTENTION" message when an existing swap file is found.
" - don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=Ac

" Folding rules {{{2

set foldenable        " Enable folding.
set foldmethod=marker " Detect triple-{ style fold marker.

" }}}2
" Command line stuff {{{2

"set wildmenu
set wildmode=list:longest,full " Bash tab style.
set completeopt=menu,menuone,longest
"set completeopt-=preview " Disable Scratch window

" Ignore these filenames during enhanced command line completion:
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpe?g,*.png,*.bmp,*.gif        " Binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.sassc,*.scssc,.sass-cache      " Sass cache files
set wildignore+=.svn,.git,.gitkeep               " SCM stuff
set wildignore+=.bundle                          " Ruby
set wildignore+=.DS_Store                        " OSX bullshit
set wildignore+=.tmp,.cache,.vendors
set wildignore+=tags                             " ctags stuff

set tags+=/
set tags+=./.git/tags,tags

" }}}2
" Statusline {{{2

set noshowmode                                 " Hide mode line text since it's already in Airline

if !exists('*airline#update_statusline')
  set statusline=%-3.3n\                       " buffer number
  set statusline+=%f                           " Path.
  set statusline+=%m                           " Modified flag.
  set statusline+=%r                           " Readonly flag.
  set statusline+=%w                           " Preview window flag.
  set statusline+=\                            " Space.
  set statusline+=%#warningmsg#                " Highlight the following as a warning.
  if exists('*SyntasticStatuslineFlag')
    set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
    set statusline+=%*                           " Reset highlighting.
    set statusline+=%=                           " Right align.
  endif

  " File format, encoding and type.  Ex: "(unix/utf-8/python)"
  set statusline+=(
  set statusline+=%{&ff}                        " Format (unix/DOS).
  set statusline+=/
  set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
  set statusline+=/
  set statusline+=%{&ft}                        " Type (python).
  set statusline+=)

  " Line and column position and counts.
  set statusline+=\ (line\ %l\/%L\/%P,\ col\ %03c)
endif

" }}}2
" }}}1
" Section: Text formatting {{{1

set tabstop=2        " A tab is 2 spaces.
set shiftwidth=2     " Number of spaces to use for autoindenting.
set softtabstop=2    " When hitting <BS>, pretend like a tab is removed, even if spaces.
set expandtab        " Expand tabs by default.
set copyindent       " Copy the previous indentation on autoindenting.
set wrap             " Wrap lines.
set nojoinspaces     " Only insert 1 space
set nrformats+=alpha " Single alphabetical characters will be incremented or decremented.

set formatoptions+=1 " When wrapping paragraphs, don't end lines with 1-letter words.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set infercase        " Ignore case on insert completion.
set textwidth=120
if executable('par')
  set formatprg=par\ -w120re
endif

" }}}1
" Section: Extra configuration {{{1

if ! has('nvim')
  call ppm#source('config/compat.vim')
endif

call ppm#source('config/plugins.vim')
call ppm#source('config/mappings.vim')
call ppm#source('config/commands.vim')
call ppm#source('config/autocommands.vim')
call ppm#source('config/filetypes.vim')

if filereadable(expand("$HOME/.local/vimrc"))
  source $HOME/.local/vimrc
endif
if has('nvim')
  if filereadable(expand("$XDG_DATA_HOME/nvim/init.vim"))
    source $XDG_DATA_HOME/nvim/init.vim
  endif
endif

" }}}1
" Section: Colorscheme {{{1

try
  set background=dark
  colorscheme iceberg
  let g:airline_theme='iceberg'
catch 'Cannot find color scheme iceberg'
  set background=light
  colorscheme morning
  let g:airline_theme='aurora'
endtry

" }}}1
