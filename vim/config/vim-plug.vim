if has('nvim')
  call plug#begin($XDG_DATA_HOME . '/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

" Section: Vim improvments {{{1
" ------------------------

Plug 'embear/vim-localvimrc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" <space>p to list files from root directory
" <space><space> to list current directory
" <space>b to list buffers
" <space>m to list MRU
" <space>o to list bookmarked directories
" <space>t to list tags within the current buffer
Plug 'ctrlpvim/ctrlp.vim'

" <space>rr to launch :Ranger
" <space>rw to launch :RangerWorkingDirectory
" Note: internally ranger.vim uses Bclose.vim
" this one does not leave a tray [No name] buffer at startup
Plug 'moll/vim-bbye' | Plug 'francoiscabrol/ranger.vim'
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

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

" . to repeat the last command
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

Plug 'chrisbra/unicode.vim'

" <leader><leader>f
Plug 'easymotion/vim-easymotion'

Plug 'chaoren/vim-wordmotion'
Plug 'lfv89/vim-interestingwords'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'

Plug 'mhinz/vim-startify'
"Plug 'hecal3/vim-leader-guide'

" M-p to cycle backward through the history of yanks
" M-P to cycle forwards through the history of yanks
Plug 'maxbrunsfeld/vim-yankstack'

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

" ]c to jump to next hunk
" [c to jump to previous hunk
" <leader>hs to stage the hunk
" <leader>hu to undo the hunk
" <leader>hp to preview the hunk
"
" New hunk text object:
" ic operates on all lines in the current hunk
" ac operates on all lines in the current hunk and any trailing empty lines
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

Plug 'luochen1990/rainbow', { 'on': ['RainbowToggle', 'RainbowToggleOn', 'RainbowToggleOff'] }

"Plug 'vim-utils/vim-troll-stopper'

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'ervandew/supertab'

" }}}1
" Section: External tools {{{1

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" }}}1
" Section: Language Server Protocol {{{1

" (optional) language server protocol framework
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" (optional) php completion via LanguageClient-neovim
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

Plug 'roxma/nvim-completion-manager'

" (optional) javascript completion
"Plug 'roxma/nvim-cm-tern',  {'do': 'yarn install'}

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
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'less'] }

" <D-C> to display colorpicker and insert hex color
" <D-R> to display colorpicker and insert rgb color
" <D-V> to display colorpicker and insert hsl color
" <D-W> to display colorpicker and insert rgba color
Plug 'KabbAmine/vCoolor.vim', {
      \ 'for': ['css', 'scss', 'less', 'javascript', 'php', 'vim'],
      \ }

" }}}2
" JavaScript {{{2

Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.mustache' }
Plug 'jaawerth/neomake-local-eslint-first', { 'for': 'javascript' }

" :JsDoc - Insert JSDoc if the cursor is on `function` keyword line.
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }

" Completion for roxma/nvim-completion-manager
Plug 'roxma/nvim-cm-tern',  { 'do': 'yarn global add tern && yarn install' }

"Plug 'othree/yajs.vim', { 'for': 'javascript' }
"Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
"Plug 'gavocanov/vim-js-indent'
"Plug 'ternjs/tern_for_vim'
"Plug 'Valloric/YouCompleteMe'

" }}}2
" PHP {{{2

"Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
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

Plug 'ryanoasis/vim-devicons'
Plug 'AfterColors.vim'

Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'

Plug 'iCyMind/NeoSolarized' " Neovim
Plug 'MaxSt/FlatColor' " Neovim
Plug 'joshdick/onedark.vim' " Neovim

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'w0ng/vim-hybrid'
Plug 'easysid/mod8.vim'
Plug 'chriskempson/base16-vim'

" :ColorToggle to toggle hex to colors
Plug 'lilydjwg/colorizer', { 'on': 'ColorToggle' }

" }}}1

call plug#end()

