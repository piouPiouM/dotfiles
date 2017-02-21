call plug#begin('~/.vim/bundle')

" Section: Vim improvments {{{1
" ------------------------

Plug 'embear/vim-localvimrc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'

" <C-a>/<C-x> to increment dates, times
Plug 'tpope/vim-speeddating'

" :Remove - Delete a buffer and the file on disk simultaneously
" :Unlink - Like :Remove, but keeps the now empty buffer
" :Move   - Rename a buffer and the file on disk simultaneously
" :Rename - Like :Move, but relative to the current file's containing directory
" :Chmod  - Change the permissions of the current file
" :Mkdir  - Create a directory, defaulting to the parent of the current file
" :Find   - Run find and load the results into the quickfix list
" :Locate - Run locate and load the results into the quickfix list
" :Wall   -  Write every open window. Handy for kicking off tools like guard
" :SudoWrite - Write a privileged file with sudo
" :SudoEdit  - Edit a privileged file with sudo
Plug 'tpope/vim-eunuch'

" . - repeat the last command
Plug 'tpope/vim-repeat'

" > "Hello world!"
" cs"'
" > 'Hello world!'
" cs'<q>
" > <q>Hello world!</q>
" cst"
" > "Hello world!"
" ds"
" > Hello world!
" ysiw]
" > [Hello] world!
" cs]{
" > { Hello } world!
" yssb or yss)
" > ({ Hello } world!)
" ds{ds)
" > Hello world!
" VS<p class="important">
" > <p class="important">
" >   Hello world!
" > </p>
Plug 'tpope/vim-surround'

" ga on a character reveals its representation in decimal, octal, and hex
" Unicode character names, Vim digraphs (for <C-K>), emoji, HTML entities
Plug 'tpope/vim-characterize'

Plug 'easymotion/vim-easymotion'
Plug 'chaoren/vim-wordmotion'
Plug 'lfv89/vim-interestingwords'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'

Plug 'mhinz/vim-startify'
"Plug 'hecal3/vim-leader-guide'

" y to highlight yank
Plug 'machakann/vim-highlightedyank'

" emoji#for('small_blue_diamond')
Plug 'junegunn/vim-emoji'

"Plug 'kshenoy/vim-signature'
"Plug 'unimpaired.vim'

" }}}1
" Section: Dev Tools {{{1
" ------------------

Plug 'dharanasoft/rtf-highlight'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'scss', 'javascript', 'php'] }
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'

" Usefull to display the current branch in vim-airline
Plug 'tpope/vim-fugitive'

" Show a diff using Vim its sign column
"Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'

" <leader>aw to (un)wrap function arguments, lists and dictionaries
Plug 'FooSoft/vim-argwrap'

"Plug 'majutsushi/tagbar', { 'tag': 'v2.7' }

" <D-F> - :Ack
Plug 'mileszs/ack.vim', { 'on': 'Ack' }

Plug 'benekastah/neomake'
Plug 'Tag-Signature-Balloons'
"Plug 'Yggdroot/indentLine'

" Auto close parentheses and repeat by dot dot dot
Plug 'cohama/lexima.vim'

" }}}1
" Section: Syntax {{{1
" ---------------

" Global {{{2

Plug 'sheerun/vim-polyglot'

" Git syntax highlighting
Plug 'tpope/vim-git'

" }}}2
" CSS {{{2

" Uses :ColorToggle for javascript and php.
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'less']}

" <D-C> to display colorpicker and insert hex color
" <D-R> to display colorpicker and insert rgb color
" <D-V> to display colorpicker and insert hsl color
" <D-W> to display colorpicker and insert rgba color
Plug 'KabbAmine/vCoolor.vim', { 'for': ['css', 'scss', 'less', 'javascript', 'php']}

" }}}2
" JavaScript {{{2

Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.mustache' }
Plug 'jaawerth/neomake-local-eslint-first', { 'for': 'javascript' }

"Plug 'othree/yajs.vim', { 'for': 'javascript' }
"Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
"Plug 'gavocanov/vim-js-indent'
"Plug 'ternjs/tern_for_vim'
"Plug 'Valloric/YouCompleteMe'

" }}}2
" PHP {{{2

Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
"Plug 'lvht/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }

" <F2> - step over
" <F3> - step into
" <F4> - step out
" <F6> - stop debugging (kills script)
" <F7> - detach script from debugger
" <F9> - run to cursor
" <F10> - toggle line breakpoint
" <F11> - show context variables (e.g. after "eval")
" <F12> - evaluate variable under cursor
" :Breakpoint <type> <args> - set a breakpoint of any type (see :help VdebugBreakpoints)
" :VdebugEval <code> - evaluate some code and display the result
" <Leader>e - evaluate the expression under visual highlight and display the result
Plug 'joonty/vdebug', { 'for': 'php' }

" }}}2
" }}}1
" Section: Text Manipulation {{{1
" --------------------------

" - to switch segment of text with predefined replacements
" :Switch
Plug 'AndrewRadev/switch.vim'

" Table creator
" <leader>tm - :TableModeToggle
Plug 'dhruvasagar/vim-table-mode', {'on': ['TableModeToggle', 'TableModeEnable']}

" A tool for aligning text by some character.
" gl to add spaces to the left
" gL to add spaces to the right
Plug 'tommcdo/vim-lion'

"Plug 'godlygeek/tabular'

" }}}1
" Section: Colorscheme bundles {{{1
" ----------------------------

Plug 'AfterColors.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'

" :ColorToggle to toggle hex to colors
Plug 'lilydjwg/colorizer', { 'on': 'ColorToggle' }

" }}}1

call plug#end()

