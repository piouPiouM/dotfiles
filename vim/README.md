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

### File navigation

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `F1`     | N I   | Launch FuzzyFinder from the directory of the current buffer | FuzzyFinder
| `⇧F1`    | N I   | Launch FuzzyFinder in Buffer mode | FuzzyFinder
| `⌥F1`    | N I   | Launch FuzzyFinder in File mode, with full path of the current directory | FuzzyFinder

### Search / Code navigation

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `⌘*`     | N     | Highlight all occurrences of current word, like `*` but without moving | |
| `//`     | N     | Cleat out search | |
| `^Space` | N I   | Omnicomplete | |

### Movements

| Keymap   | Modes | Action | Dependency |
|----------|-------|--------|------------|
| `,.`     | N     | Go to last edit location | |
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

Installed plugins
-----------------

1. Ack.vim
1. AfterColors
1. Align
1. CoffeScript
1. Command-T
1. Delimitmate
1. Easymotion
1. Fugitive
1. FuzzyFinder
1. Gist
1. Gundo
1. L9 (as dependence)
1. NerdCommenter
1. NerdTree
1. PHPComplete
1. Pathogen
1. Powerline
1. Repeat
1. SessionMan
1. SnipMate
1. Surround
1. Syntastic
1. Tagbar
1. Unimpaired
1. Yankring
1. hexHighlight

TODO
----

* Add support for Drupal projects.
* Uninstall plugins:
    - Command-T
    - FuzzyFinder
    - NerdTree
    - SessionMan
    - Delimitmate?
* Install plugins:
    - [CtrlP](https://github.com/kien/ctrlp.vim) in replacement of FuzzyFinder and Command-T.
    - [extradite](https://github.com/int3/vim-extradite): a git commit browser for vim (extends Fugitive).
    - [ZoomWin](https://github.com/vim-scripts/ZoomWin): zoom in/out of windows (toggle between one window and
      multi-window).
    - [SuperTab](https://github.com/ervandew/supertab/)?: perform all your vim insert mode completions with Tab.
    - [NrrwRgn](https://github.com/chrisbra/NrrwRgn])?: a Narrow Region Plugin for vim (like Emacs Narrow Region).
    - [Easytags](https://github.com/xolox/vim-easytags): automated tag file generation and syntax highlighting of tags
      in Vim.
    - [Threesome](http://stevelosh.com/projects/threesome/): a plugin for resolving conflicts during three-way merges.

