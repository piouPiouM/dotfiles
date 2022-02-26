silent! if plug#begin($XDG_DATA_HOME . '/nvim/bundle')

" Section: Plug tools {{{1

function! PlugRemotePlugins(info) abort
  if has('nvim')
    UpdateRemotePlugins
  endif
endfunction

function! PlugNpmPlugin(info) abort
  !npm install
  call PlugRemotePlugins(a:info)
endfunction

Plug 'dstein64/vim-startuptime'

" }}}1
" Section: Tmux {{{1

" Note: turn on `focus-events` option in Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" }}}1
" Section: Vim improvments {{{1

Plug 'embear/vim-localvimrc'
Plug 'nvim-lualine/lualine.nvim'

" :DimInactiveOn / :DimInactiveOff
" :DimInactiveSyntaxOn / :DimInactiveSyntaxOff
" :DimInactiveColorcolumnOn / :DimInactiveColorcolumnOff
" :DimInactiveWindowOn / :DimInactiveWindowOff
" :DimInactiveWindowReset
" :DimInactiveBufferOn / :DimInactiveBufferOff
" :DimInactiveBufferReset
" Plug 'blueyed/vim-diminactive'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" :MaximizerToggle - Maximize or restore windows.
" F3 in Normal, Visual and Insert modes.
Plug 'szw/vim-maximizer'

"Plug 'wincent/scalpel'
Plug 'wincent/vim-docvim'

" Text objects {{{2

" DO NOT REMOVE
Plug 'kana/vim-textobj-user'

" Adds text objects for word-based columns in Vim
" ac
" ic
" aC
" iC
" TODO: to replace with rhysd/vim-textobj-word-column
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

" <leader><leader>f
Plug 'easymotion/vim-easymotion'

" <leader>w
" <leader>b
" <leader>e
" <leader>ge
" <leader>aw
" <leader>iw
Plug 'chaoren/vim-wordmotion'

" mm to add/remove bookmark at current line
" mi to add/edit/remove annotation at current line
" mn to jump to next bookmark in buffer
" mp to jump to previous bookmark in buffer
" ma to show all bookmarks (toggle)
" mc to clear bookmarks in current buffer only
" mc to clear bookmarks in all buffers
" [count]mkk to move up bookmark at current line
" [count]mjj to move down bookmark at current line
" [count]mg to move bookmark at current line to another line
" :BookmarkSave <FILE_PATH> - Save all bookmarks to a file
" :BookmarkLoad <FILE_PATH> - Load bookmarks from a file
Plug 'MattesGroeger/vim-bookmarks'

" :UndotreeToggle - Toggle undo-tree panel
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" vv to select quickly text between markers (<, >, ", ', `, (, ), [, ], {, }, t)
"  v (after selection) to increase selection
" <C-S-V> to cancel last smartpairs selection
Plug 'gorkunov/smartpairs.vim'

" Friendly welcome screen
Plug 'mhinz/vim-startify'

" M-p to cycle backward through the history of yanks
" M-P to cycle forwards through the history of yanks
" Plug 'maxbrunsfeld/vim-yankstack'

" <leader>k to toggle highlighting of a word.
" <leader>K to clear all highlighted words.
" n and N to navigate through the occurrences of the word under cursor.
" Plug 'lfv89/vim-interestingwords'

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

" :ToggleWhitespace - Toggle whitespace highlighting on/off
" [range]:StripWhitespace - To clean extra whitespace
Plug 'ntpeters/vim-better-whitespace'

Plug 'rizzatti/dash.vim', {
      \ 'on': ['Dash', 'DashKeywords', '<Plug>DashSearch', '<Plug>DashGlobalSearch']
      \ }
Plug 'scrooloose/nerdcommenter'

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

" <leader>gm to display commit information of the current line
Plug 'rhysd/git-messenger.vim'

" <leader>aw to (un)wrap function arguments, lists and dictionaries
Plug 'FooSoft/vim-argwrap'

Plug 'lukas-reineke/indent-blankline.nvim'

" Auto close parentheses and repeat by dot dot dot
" Plug 'cohama/lexima.vim'

" Plug 'luochen1990/rainbow', {
      " \ 'on': ['RainbowToggle', 'RainbowToggleOn', 'RainbowToggleOff']
      " \ }

"Plug 'vim-utils/vim-troll-stopper'

" Plug 'ervandew/supertab'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" }}}1
" Section: LSP {{{1

Plug 'nvim-lua/plenary.nvim'
Plug 'tjdevries/astronauta.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" post-install the following global npm packages:
" - eslint_d
" - vscode-langservers-extracted
" - typescript typescript-language-server
" - vim-language-server
" - bash-language-server
" - @cucumber/language-server
" - emmet-ls
Plug 'neovim/nvim-lspconfig'
Plug 'arkav/lualine-lsp-progress'
Plug 'b0o/schemastore.nvim'
Plug 'folke/trouble.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'kosayoda/nvim-lightbulb'


" Completion {{{2

Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-calc'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" }}}2
" Fuzzy Finder {{{2

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" }}}2
" Syntax {{{2

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" }}}2
" }}}1
" Section: External tools {{{1

" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'

" <leader>gi to create .gitignore files using the gitignore.io API
"Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}

" }}}1
" Section: Syntax {{{1

" Versionning {{{2

" Plug 'tpope/vim-git', {
"       \ 'for': ['git', 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail'],
"       \ 'on': ['DiffGitCached'],
"       \ }

" TODO: fork it to remove the "snippets" templates
" Plug 'gisphm/vim-gitignore', { 'for': 'gitignore' }

" }}}2
" CSS {{{2

" Uses :ColorToggle for javascript and php.
" Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'less'] }

" <M-c> to display colorpicker and insert hex color
" <M-r> to display colorpicker and insert rgb color
" <M-v> to display colorpicker and insert hsl color
" <M-w> to display colorpicker and insert rgba color
" :VCase - Toggle between lower/upper case for the returned hex color
Plug 'KabbAmine/vCoolor.vim', {
      \ 'for': ['css', 'scss', 'less', 'javascript', 'typescript', 'php', 'vim', 'tmux'],
      \ }

" }}}2
" JavaScript {{{2

" Plug 'othree/javascript-libraries-syntax.vim', {
      " \ 'for': ['javascript', 'javascript.jsx']
      " \ }
" Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.mustache' }

" Plug 'Quramy/vim-js-pretty-template', {
"       \ 'for': ['javascript', 'typescript']
"       \ }

" :JsDoc - Insert JSDoc if the cursor is on `function` keyword line.
" Plug 'heavenshell/vim-jsdoc', {
"       \ 'for': ['javascript', 'javascript.jsx', 'typescript']
"       \ }

" Plug 'styled-components/vim-styled-components', {
"       \ 'branch': 'main',
"       \ 'for': ['javascript', 'javascript.jsx', 'typescript']
"       \ }

" Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

" Plug 'meain/vim-package-info', {
"       \ 'do': function('PlugNpmPlugin'),
"       \ }

" }}}2
" PHP {{{2

" :Composer command wrapper around composer with smart completion
" Plug 'noahfrederick/vim-composer', { 'for': 'php' }

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
" Plug 'joonty/vdebug', { 'for': 'php' }

" }}}2
" Tabular data {{{2

" Plug 'chrisbra/csv.vim', { 'for': 'csv' }

" }}}2
" Polyglot {{{2

" let g:polyglot_disabled = ['elm', 'typescript']
" Plug 'sheerun/vim-polyglot'

" After vim-polyglot to avoid overriding.
" Plug 'neoclide/jsonc.vim'

" }}}2
" Misc {{{2

Plug 'fladson/vim-kitty'

" }}}2

" }}}1
" Section: Text Manipulation {{{1

" - to switch segment of text with predefined replacements
" :Switch
Plug 'AndrewRadev/switch.vim'

" Table creator
" <leader>tm - :TableModeToggle
Plug 'dhruvasagar/vim-table-mode', {
      \ 'on': ['TableModeToggle', 'TableModeEnable']
      \ }

" A tool for aligning text by some character.
" [count]gl[motion][character] to add spaces to the left
" [count]gL[motion][character] to add spaces to the right
" Ex:
"   glip=
"   3gLi(,
Plug 'tommcdo/vim-lion'

" }}}1
" Section: Colorscheme stuff {{{1

" :HexokinaseToggle to toggle the colouring
" :HexokinaseRefresh to refresh the colouring
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

" :HLT to reveal a linked list of highlighting from the top-level down to
"      the bottom level for the cursor position.
" :HLT! same as :HTL but will execute on every CursorMoved event.
" <leader>htl same as :HTL.
Plug 'gerw/vim-HiLinkTrace', {
      \ 'on': 'HLT'
      \ }

" Pinnacle provides functions for manipulating `:highlight` groups.
Plug 'wincent/pinnacle'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'cocopon/iceberg.vim'
Plug 'antonk52/lake.vim'
" Plug 'crispgm/nord-vim'
Plug 'shaunsingh/nord.nvim'
Plug 'maaslalani/nordbuddy'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim'

" }}}1

call plug#end()
endif
