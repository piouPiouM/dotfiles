if !exists("loaded_nerd_tree")
  finish
endif

let g:NERDTreeMinimalUI = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME . '/nvim/NERDTreeBookmarks'

