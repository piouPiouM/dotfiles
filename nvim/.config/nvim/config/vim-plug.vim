silent! if plug#begin($XDG_DATA_HOME . '/nvim/bundle')

" Section: Plug tools {{{1

function! PlugRemotePlugins(info) abort
  if has('nvim')
    UpdateRemotePlugins
  endif
endfunction

function! PlugNpmPlugin(ixnfo) abort
  !npm install
  call PlugRemotePlugins(a:info)
endfunction

" Plug 'dstein64/vim-startuptime'

" }}}1
" Section: Tmux {{{1

" Note: turn on `focus-events` option in Tmux
" Plug 'tmux-plugins/vim-tmux-focus-events'

" }}}1
" Section: Vim improvments {{{1

Plug 'embear/vim-localvimrc' " STATUS: migrated
Plug 'nvim-lualine/lualine.nvim' " STATUS: migrated

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " STATUS: migrated
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " STATUS: migrated


" :MaximizerToggle - Maximize or restore windows.
" F3 in Normal, Visual and Insert modes.
Plug 'szw/vim-maximizer' " STATUS: migrated

"Plug 'wincent/scalpel'
Plug 'wincent/vim-docvim' " STATUS: migrated

" Text objects {{{2

" DO NOT REMOVE
Plug 'kana/vim-textobj-user' " STATUS: migrated

" Adds text objects for word-based columns in Vim
" ac
" ic
" aC
" iC
" TODO: to replace with rhysd/vim-textobj-word-column
Plug 'coderifous/textobj-word-column.vim' " STATUS: migrated

" a_
" i_
Plug 'lucapette/vim-textobj-underscore' " STATUS: migrated

" Provides text objects to select a block of lines which are similarly indented to the current line
" ai to select a block of lines which are similarly indented to the current line
" ii to select a block of lines which are similarly indented to the current line, without empty lines
" aI
" iI
Plug 'kana/vim-textobj-indent' " STATUS: not used

" Provides text objects to select an area which is matched to last-pattern
" a/ to select next area (same as n)
" i/ to select next area (same as n)
" a? to select previous area (same as N)
" i? to select previous area (same as N)
Plug 'kana/vim-textobj-lastpat' " STATUS: not used

" Provides two text objects: ix and ax
" ix works with the inner attribute, with no surrounding whitespace
" ax includes the whitespace before the attribute
Plug 'whatyouhide/vim-textobj-xmlattr' " STATUS: migrated

" Provides two text objects: i, and a,
" i, to inner parameter object
" a, to a parameter object including whitespaces and comma
" i2, is similar to a, except trailing whitespace characters (especially for first parameter)
Plug 'sgur/vim-textobj-parameter' " STATUS: migrated

" }}}2

" <C-a>/<C-x> to increment dates, times
Plug 'tpope/vim-speeddating' " STATUS: migrated

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
Plug 'tpope/vim-eunuch' " STATUS: migrated

" . to repeat the last command
Plug 'tpope/vim-repeat' " STATUS: migrated

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
Plug 'tpope/vim-surround' " STATUS: migrated

" <leader><leader>f
Plug 'easymotion/vim-easymotion' " STATUS: to replace with hop

" <leader>w
" <leader>b
" <leader>e
" <leader>ge
" <leader>aw
" <leader>iw
Plug 'chaoren/vim-wordmotion' " STATUS: not used

" :UndotreeToggle - Toggle undo-tree panel
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " STATUS: migrated

" vv to select quickly text between markers (<, >, ", ', `, (, ), [, ], {, }, t)
"  v (after selection) to increase selection
" <C-S-V> to cancel last smartpairs selection
Plug 'gorkunov/smartpairs.vim' " STATUS: to replace with treesitter

" Friendly welcome screen
Plug 'mhinz/vim-startify' " STATUS: migrated

" <localleader>k to highlight automatically a word under the cursor
" <localleader>] to toggle highlight of jumpable 'tag'
Plug 't9md/vim-quickhl', {
      \ 'on': ['<Plug>(quickhl-cword-toggle)', '<Plug>(quickhl-tag-toggle)']
      \ } " TODO

" }}}1
" Section: Dev Tools {{{1
" ------------------

Plug 'dharanasoft/rtf-highlight', { 'on': 'RTFHighlight' } " TODO

Plug 'editorconfig/editorconfig-vim' " STATUS: migrated

" :ToggleWhitespace - Toggle whitespace highlighting on/off
" [range]:StripWhitespace - To clean extra whitespace
Plug 'ntpeters/vim-better-whitespace' " TODO

Plug 'scrooloose/nerdcommenter' " STATUS: migrated

" ]c to jump to next hunk
" [c to jump to previous hunk
" <leader>hs to stage the hunk
" <leader>hu to undo the hunk
" <leader>hp to preview the hunk
"
" New hunk text object:
" ic operates on all lines in the current hunk
" ac operates on all lines in the current hunk and any trailing empty lines
Plug 'airblade/vim-gitgutter' " TODO

" <leader>gm to display commit information of the current line
Plug 'rhysd/git-messenger.vim' " TODO

" <leader>aw to (un)wrap function arguments, lists and dictionaries
Plug 'FooSoft/vim-argwrap' " TODO

Plug 'lukas-reineke/indent-blankline.nvim' " TODO

" }}}1
" Section: LSP {{{1

Plug 'nvim-lua/plenary.nvim' " STATUS: migrated
Plug 'kyazdani42/nvim-web-devicons' " STATUS: migrated
Plug 'mortepau/codicons.nvim' " STATUS: migrated

" post-install the following global npm packages:
" - eslint_d
" - vscode-langservers-extracted
" - typescript typescript-language-server
" - vim-language-server
" - bash-language-server
" - @cucumber/language-server
" - emmet-ls
Plug 'neovim/nvim-lspconfig' " STATUS: migrated
Plug 'j-hui/fidget.nvim' " STATUS: migrated
Plug 'b0o/schemastore.nvim' " STATUS: migrated
Plug 'folke/trouble.nvim' " STATUS: migrated
Plug 'simrat39/symbols-outline.nvim' " STATUS: migrated
Plug 'kosayoda/nvim-lightbulb' " STATUS: migrated

" Completion {{{2

Plug 'onsails/lspkind-nvim' " STATUS: migrated
Plug 'hrsh7th/nvim-cmp' " STATUS: migrated
Plug 'hrsh7th/cmp-nvim-lsp' " STATUS: migrated
Plug 'hrsh7th/cmp-nvim-lua' " STATUS: migrated
Plug 'hrsh7th/cmp-buffer' " STATUS: migrated
Plug 'hrsh7th/cmp-cmdline' " STATUS: migrated
Plug 'hrsh7th/cmp-path' " STATUS: migrated
Plug 'hrsh7th/cmp-calc' " STATUS: migrated
Plug 'hrsh7th/cmp-nvim-lsp-signature-help' " STATUS: migrated
Plug 'L3MON4D3/LuaSnip' " STATUS: migrated
Plug 'saadparwaiz1/cmp_luasnip' " STATUS: migrated
Plug 'rafamadriz/friendly-snippets' " STATUS: migrated

" }}}2
" Fuzzy Finder {{{2

Plug 'nvim-telescope/telescope.nvim' " STATUS: migrated
Plug 'nvim-telescope/telescope-ui-select.nvim' " STATUS: migrated
Plug 'nvim-telescope/telescope-file-browser.nvim' " STATUS: migrated
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " STATUS: migrated
Plug 'nvim-telescope/telescope-live-grep-args.nvim' " STATUS: migrated

" }}}2
" Syntax {{{2

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " STATUS: migrated
Plug 'nvim-treesitter/playground' " STATUS: migrated
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils' " STATUS: migrated
Plug 'JoosepAlviste/nvim-ts-context-commentstring' " STATUS: migrated

" }}}2
" }}}1
" Section: External tools {{{1

" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'

" }}}1
" Section: Syntax {{{1

" <M-c> to display colorpicker and insert hex color
" <M-r> to display colorpicker and insert rgb color
" <M-v> to display colorpicker and insert hsl color
" <M-w> to display colorpicker and insert rgba color
" :VCase - Toggle between lower/upper case for the returned hex color
Plug 'KabbAmine/vCoolor.vim', {
      \ 'for': ['css', 'scss', 'less', 'javascript', 'typescript', 'php', 'vim', 'tmux'],
      \ } " TODO
Plug 'jxnblk/vim-mdx-js' " STATUS: migrated
Plug 'VebbNix/lf-vim' " STATUS: migrated
Plug 'fladson/vim-kitty' " STATUS: migrated
Plug 'terminalnode/sway-vim-syntax' " STATUS: migrated

" }}}1
" Section: Text Manipulation {{{1

" - to switch segment of text with predefined replacements
" :Switch
Plug 'AndrewRadev/switch.vim' " STATUS: migrated

" A tool for aligning text by some character.
" [count]gl[motion][character] to add spaces to the left
" [count]gL[motion][character] to add spaces to the right
" Ex:
"   glip=
"   3gLi(,
Plug 'tommcdo/vim-lion' " STATUS: abandoned in favor of linters

" }}}1
" Section: Colorscheme stuff {{{1

" :HexokinaseToggle to toggle the colouring
" :HexokinaseRefresh to refresh the colouring
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' } " STATUS: migrated

" :HLT to reveal a linked list of highlighting from the top-level down to
"      the bottom level for the cursor position.
" :HLT! same as :HTL but will execute on every CursorMoved event.
" <leader>htl same as :HTL.
Plug 'gerw/vim-HiLinkTrace', {
      \ 'on': 'HLT'
      \ } " TODO

" Pinnacle provides functions for manipulating `:highlight` groups.
Plug 'wincent/pinnacle' " STATUS: migrated

Plug 'cocopon/iceberg.vim' " TODO
Plug 'antonk52/lake.vim' " TODO
" Plug 'crispgm/nord-vim'
Plug 'shaunsingh/nord.nvim' " STATUS: migrated
Plug 'maaslalani/nordbuddy' " STATUS: migrated
Plug 'EdenEast/nightfox.nvim' " STATUS: migrated
Plug 'catppuccin/nvim', {'as': 'catppuccin'} " STATUS: migrated

" }}}1

call plug#end()
endif
