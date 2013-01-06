Vim configuration
=================


Keymaps
-------

**Note:** the `<Leader>` key is map to a comma (`,`).

### Window management

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `ss`     | N     | Split window horizontally | |
| `vv`     | N     | Split window vertically   | |
| `,g`     | N     | Call Golden Ratio resize command | Golden Ratio |

### File navigation

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `F1`     | N I   | Launch CtrlP | CtrlP
| `⇧F1`    | N I   | Launch CtrlP in find buffer | CtrlP
| `⌥F1`    | N I   | Launch CtrlP in the current file directory | CtrlP
| `,F1`    | N I   | Launch CtrlP in MRU mode | CtrlP

### Search / Code navigation

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `⌘*`     | N     | Highlight all occurrences of current word, like `*` but without moving | |
| `//`     | N     | Clear out search | |
| `,/`     | N     | Open a Quickfix window for the last search | |
| `,//`    | N     | Close a Quickfix window | |
| `^Space` | N I   | Omnicomplete | |
| `⇧⌘f`    | N I   | Find in project | Ack.vim |
| `<expr>⇥`  | I     | Complete next suggestion | Neocomplcache |
| `<expr>⇧⇥` | I     | Complete previous suggestion | Neocomplcache |

### Movements

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `⌃↑`     | N   V | Bubbling text to up   | Unimpaired
| `⌃↓`     | N   V | Bubbling text to down | Unimpaired

### Utility

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `F3`     | N I   | Paste from history | Yankring |
| `⌘u`     | N     | Toggle undo window | Gundo |
| `⌘'`     | N I   | Change inside simple quotes | |
| `⌘"`     | N I   | Change inside double quotes | |
| `^a`     |   I   | Jump after autocompleted quote | |
| `,a=`    | N   V | Align to equals signs | Tabular |
| `,a:`    | N   V | Align after the colons | Tabular |

Installed plugins
-----------------

1. Ack.vim
1. AfterColors
1. CoffeScript
1. ctrlp.vim
1. Easymotion
1. Gist
1. Golden Ratio
1. Gundo
1. Haml
1. L9 (as dependency)
1. NerdCommenter
1. PHPComplete
1. Powerline
1. Repeat
1. Surround
1. Syntastic
1. Tagbar
1. [Tabular][]
1. Unimpaired
1. Vundle
1. Yankring
1. hexHighlight
1. [AutoClose][]
1. [Neocomplcache][]
1. [matchit.vim][matchit]

TODO
----

* Add support for Drupal projects.
* Install plugins:
    - Align
    - SnipMate
    - Fugitive
    - [extradite](https://github.com/int3/vim-extradite): a git commit browser for vim (extends Fugitive).
    - [ZoomWin](https://github.com/vim-scripts/ZoomWin): zoom in/out of windows (toggle between one window and
      multi-window).
    - [SuperTab](https://github.com/ervandew/supertab/)?: perform all your vim insert mode completions with Tab.
    - [NrrwRgn](https://github.com/chrisbra/NrrwRgn])?: a Narrow Region Plugin for vim (like Emacs Narrow Region).
    - [Easytags](https://github.com/xolox/vim-easytags): automated tag file generation and syntax highlighting of tags
      in Vim.
    - [Threesome](http://stevelosh.com/projects/threesome/): a plugin for resolving conflicts during three-way merges.
    - [XDebug](https://github.com/vim-scripts/Xdebug) or [DBGPavim](https://github.com/vim-scripts/DBGPavim).

[AutoClose]: https://github.com/Townk/vim-autoclose
[Neocomplcache]: https://github.com/vim-scripts/neocomplcache
[matchit]: https://github.com/vim-scripts/matchit.zip
[Tabular]: https://github.com/godlygeek/tabular

