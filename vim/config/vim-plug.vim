call plug#begin($XDG_DATA_HOME . '/nvim/bundle')

" Section: Tmux {{{1

" Note: turn on `focus-events` option in Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" }}}1
" Section: Vim improvments {{{1

Plug 'embear/vim-localvimrc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" <leader>fml to display all <leader> mappings
Plug 'ktonga/vim-follow-my-lead'

" DimInactiveOn / DimInactiveOff
" DimInactiveSyntaxOn / DimInactiveSyntaxOff
" DimInactiveColorcolumnOn / DimInactiveColorcolumnOff
" DimInactiveWindowOn / DimInactiveWindowOff
" DimInactiveWindowReset
" DimInactiveBufferOn / DimInactiveBufferOff
" DimInactiveBufferReset
Plug 'blueyed/vim-diminactive'

" <space>p to list files from root directory
" <space><space> to list current directory
" <space>b to list buffers
" <space>m to list MRU
" <space>o to list bookmarked directories
" <space>t to list tags within the current buffer
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Display the contents of the registers on the sidebar
" @[choise][motion] or "[choise][motion] in normal mode
" <C-R> in insert mode
Plug 'junegunn/vim-peekaboo'

" :MaximizerToggle to maximize or restore windows.
" F3 in Normal, Visual and Insert modes.
Plug 'szw/vim-maximizer'

"Plug 'wincent/scalpel'
Plug 'chase/vim-ansible-yaml'
Plug 'wincent/vim-docvim'

" Text objects {{{2

" DO NOT REMOVE
Plug 'kana/vim-textobj-user'

" Adds text objects for word-based columns in Vim
" ac
" ic
" aC
" iC
Plug 'coderifous/textobj-word-column.vim'


" a_
" i_
Plug 'lucapette/vim-textobj-underscore'

" Provides text objects to select a block of lines which are similarly indented to the current line
" ai to select a block of lines which are similarly indented to the current line
" ii to select a block of lines which are similarly indented to the current line, without empty lines
" aI
" iI
Plug 'kana/vim-textobj-indent'

" Provides text objects to select an area which is matched to last-pattern
" a/ to select next area (same as n)
" i/ to select next area (same as n)
" a? to select previous area (same as N)
" i? to select previous area (same as N)
Plug 'kana/vim-textobj-lastpat'

" Provides two text objects: ix and ax
" ix works with the inner attribute, with no surrounding whitespace
" ax includes the whitespace before the attribute
Plug 'whatyouhide/vim-textobj-xmlattr'

" Provides two text objects: i, and a,
" i, to inner parameter object
" a, to a parameter object including whitespaces and comma
" i2, is similar to a, except trailing whitespace characters (especially for first parameter)
Plug 'sgur/vim-textobj-parameter'

" }}}2

" :ShrinkMapToggle or <leader>ss - Open or close ShrinkMap sidebar
" :ShrinkMapOpen   or <leader>so - Open ShrinkMap sidebar
" :ShrinkMapClose  or <leader>sc - Close ShrinkMap sidebar
" :ShrinkMapUpdate or <leader>su - Draw Braille patterns to ShrinkMap sidebar and highlight the current window in ShinkMap sidebar
Plug 'ryujinno/shrinkmap.vim'

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

" Do not load lazily because otherwise an E117 error is throwned by Airline.
Plug 'chrisbra/unicode.vim'

" <leader><leader>f
Plug 'easymotion/vim-easymotion'

Plug 'chaoren/vim-wordmotion'

Plug 'MattesGroeger/vim-bookmarks'

" <F5> to toggle undo-tree panel
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" + to expand the visual selection
" _ to shrink the visual selection
Plug 'terryma/vim-expand-region', {
      \ 'on': ['<Plug>(expand_region_expand)', '<Plug>(expand_region_shrink)']
      \ }

" Friendly welcome screen
Plug 'mhinz/vim-startify'

" M-p to cycle backward through the history of yanks
" M-P to cycle forwards through the history of yanks
Plug 'maxbrunsfeld/vim-yankstack'

" y to highlight yank
Plug 'machakann/vim-highlightedyank'

" emoji#for('small_blue_diamond')
Plug 'junegunn/vim-emoji'

" <leader>k to toggle highlighting of a word.
" <leader>K to clear all highlighted words.
" n and N to navigate through the occurrences of the word under cursor.
Plug 'lfv89/vim-interestingwords'

" <localleader>k to highlight automatically a word under the cursor
" <localleader>] to toggle highlight of jumpable 'tag'
Plug 't9md/vim-quickhl', {
      \ 'on': ['<Plug>(quickhl-cword-toggle)', '<Plug>(quickhl-tag-toggle)']
      \ }

" }}}1
" Section: Dev Tools {{{1
" ------------------

Plug 'dharanasoft/rtf-highlight', { 'on': 'RTFHighlight' }

Plug 'editorconfig/editorconfig-vim'

" <C-y>, to expand abbreviations similar to emmet
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'scss', 'javascript', 'php'] }

Plug 'ntpeters/vim-better-whitespace'

Plug 'rizzatti/dash.vim', {
      \ 'on': ['Dash', 'DashKeywords', '<Plug>DashSearch', '<Plug>DashGlobalSearch']
      \ }
Plug 'scrooloose/nerdcommenter'

" Usefull to display the current branch in vim-airline
Plug 'tpope/vim-fugitive'

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

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" <D-F> - :Ack
Plug 'mileszs/ack.vim', { 'on': 'Ack' }

" <C-k> to jump to the next error
" <C-j> to jump to the previous error
Plug 'w0rp/ale'

Plug 'Yggdroot/indentLine'

" Auto close parentheses and repeat by dot dot dot
Plug 'cohama/lexima.vim'

Plug 'luochen1990/rainbow', { 'on': ['RainbowToggle', 'RainbowToggleOn', 'RainbowToggleOff'] }

"Plug 'vim-utils/vim-troll-stopper'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" }}}1
" Section: Language Server Protocol {{{1

" Performs installation of LanguageServer-neovim and usefull services.
" https://github.com/autozimu/LanguageClient-neovim/issues/83#issuecomment-323446843
function! InstallVSCodeLanguageServices(info)
  !./install.sh
  !npm install --global
        \ vscode-css-languageserver-bin
        \ vscode-html-languageserver-bin
        \ vscode-json-languageserver-bin
endfunction

" Language server protocol framework
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': function('InstallVSCodeLanguageServices')
      \ }

" PHP completion via LanguageClient-neovim
Plug 'roxma/LanguageServer-php-neovim',  {
      \ 'do': 'composer install && composer run-script parse-stubs'
      \ }

" }}}1
" Section: Completion {{{1

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'tenfyzhong/CompleteParameter.vim'

" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

"Plug 'roxma/nvim-completion-manager'

" }}}1
" Section: External tools {{{1

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" <leader>gi to create .gitignore files using the gitignore.io API
"Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}

" }}}1
" Section: Syntax {{{1

" Versionning {{{2

" Git syntax highlighting
Plug 'tpope/vim-git'

" }}}2
" CSS {{{2

" Uses :ColorToggle for javascript and php.
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'less'] }

" <C-o>h to display colorpicker and insert hex color
" <C-o>r to display colorpicker and insert rgb color
" <C-o>s to display colorpicker and insert hsl color
" <C-o>a to display colorpicker and insert rgba color
Plug 'KabbAmine/vCoolor.vim', {
      \ 'for': ['css', 'scss', 'less', 'javascript', 'typescript', 'php', 'vim', 'tmux'],
      \ }

" }}}2
" Elm {{{2

" <Leader>m to compile the current buffer.
" <Leader>b to compile the Main.elm file in the project.
" <Leader>t to runs the tests of the current buffer or 'tests/TestRunner'.
" <Leader>r to opens an elm repl in a subprocess.
" <Leader>e to shows the detail of the current error or warning.
" <Leader>d to shows the type and docs for the word under the cursor.
" <Leader>w to opens the docs web page for the word under the cursor.
" :ElmMake [filename] calls elm-make with the given file. If no file is given it uses the current file being edited.
" :ElmMakeMain attempts to call elm-make with "Main.elm".
" :ElmTest calls elm-test with the given file. If no file is given it runs it in the root of your project.
" :ElmRepl runs elm-repl, which will return to vim on exiting.
" :ElmErrorDetail shows the detail of the current error in the quickfix window.
" :ElmShowDocs queries elm-oracle, then echoes the type and docs for the word under the cursor.
" :ElmBrowseDocs queries elm-oracle, then opens docs web page for the word under the cursor.
" :ElmFormat formats the current buffer with elm-format.
"\ 'do': 'npm install --global elm elm-test elm-oracle elm-format',
Plug 'elmcast/elm-vim', {
      \ 'for': ['elm']
      \ }
Plug 'pbogut/deoplete-elm'

" }}}2
" JavaScript {{{2

Plug 'othree/javascript-libraries-syntax.vim', {
      \ 'for': ['javascript', 'javascript.jsx']
      \ }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.mustache' }

" :JsDoc - Insert JSDoc if the cursor is on `function` keyword line.
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'ternjs/tern_for_vim', {
      \ 'do': 'npm install && npm install --global tern',
      \ 'for': ['javascript', 'javascript.jsx']
      \ }
Plug 'carlitux/deoplete-ternjs', {
      \ 'for': ['javascript', 'javascript.jsx']
      \ }
Plug 'othree/jspc.vim', {
      \ 'for': ['javascript', 'javascript.jsx', 'typescript']
      \ }
"Plug 'tenfyzhong/CompleteParameter.vim'

function! InstallTypeScript(info)
  !npm install --global typescript
  UpdateRemotePlugins
endfunction
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'mhartington/nvim-typescript', {
      \ 'do': function('InstallTypeScript'),
      \ 'for': 'typescript'
      \ }

" }}}2
" PHP {{{2

" :Composer command wrapper around composer with smart completion
Plug 'noahfrederick/vim-composer', { 'for': 'php' }

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
" Tabular data {{{2

Plug 'chrisbra/csv.vim', { 'for': 'csv' }

" }}}2
" Polyglot {{{2

Plug 'sheerun/vim-polyglot'

" }}}2
" }}}1
" Section: Text Manipulation {{{1

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
" Section: Colorscheme stuff {{{1

Plug 'vim-scripts/AfterColors.vim'

" :ColorToggle to toggle hex to colors
Plug 'lilydjwg/colorizer', {
      \ 'on': ['ColorHighlight', 'ColorClear', 'ColorToggle']
      \ }

" :HLT to reveal a linked list of highlighting from the top-level down to
"      the bottom level for the cursor position.
" :HLT! same as :HTL but will execute on every CursorMoved event.
" <leader>htl same as :HTL.
Plug 'gerw/vim-HiLinkTrace'

" Pinnacle provides functions for manipulating `:highlight` groups.
Plug 'wincent/pinnacle'

Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'iCyMind/NeoSolarized'
Plug 'w0ng/vim-hybrid'
Plug 'easysid/mod8.vim'
Plug 'chriskempson/base16-vim'
Plug 'cocopon/iceberg.vim'

" }}}1

call plug#end()

