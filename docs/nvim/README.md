# Neovim

I've been using Vim and Neovim for nearly 15 years. Its configuration is constantly evolving according to my needs, my curiosity and the new features offered by the community.

My **leader key** is the `Space` and my *local leader key* is `ù` because these keys are easily accessible from an AZERTY keyboard.

## Plugins

I use [many plugins](https://github.com/piouPiouM/dotfiles/blob/master/nvim/.config/nvim/lua/plugins/), the main ones being :

- [lazy.nvim](https://github.com/folke/lazy.nvim) for manage my plugins
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)  as langage parser
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) as LSP configuration helper
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) for improve Neovim LSP experience
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) as powerful fuzzy finder 🌸
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) as completion engine
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for customize the status bar, tabs and winbar
- [leap.nvim](https://github.com/ggandor/leap.nvim) as motion helper 🦘
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) to integrate Git into Neovim

## Pickers

Like everyone else, I use a set of pickers to navigate efficiently through my code bases. These pickers are powered by [fzf-lua](https://github.com/ibhagwan/fzf-lua), which offers great responsiveness. Accustomed to the layouts of the Telescope plugin, I have created [4 new themes](./.config/nvim/lua/ppm/plugin/fzf-lua/themes.lua) for fzf-lua:

| Theme           | Screenshot |
| --------------- | ---------- |
| `cursor`        | ![Neovim: cursor picker](https://github.com/piouPiouM/dotfiles/assets/22614/4eb10ec9-3a32-4e02-9474-8198f255e7ba "Nerd Fonts' symbols picker powered by fzf-lua")        |
| `ivy`           | ![Neovim: ivy picker](https://github.com/piouPiouM/dotfiles/assets/22614/183b8a88-5bb8-4833-9245-c700b37f027b)           |
| `sidebar_right` | ![Neovim: sidebar_right picker](https://github.com/piouPiouM/dotfiles/assets/22614/ffd35b2a-07c0-455b-94b2-a650528b7663)        |
| `vertical`      | ![Neovim: vertical picker](https://github.com/piouPiouM/dotfiles/assets/22614/8253206c-8b38-4809-ae95-0962b2a79fc2)        |
### Keymaps

List of keyboard shortcuts assigned to certain pickers:

| Type   | Modes | Keymap            | Action                                                                           |
| ------ | ----- | ----------------- | -------------------------------------------------------------------------------- |
|        | n     | `<leader>r`       | Resume last search                                                               |
| file   | n     | `<leader><space>` | Find files in current opened buffer's directory                                  |
| file   | n     | `<leader>p`       | Search files from the project's root directory, ignoring content of `.gitignore` |
| file   | n     | `<leader>fa`      | Search files from the project's root directory without any restriction           |
| file   | n     | `<leader>s`       | Search files in git repository                                                   |
| grep   | n     | `<leader>fg`      | Live search                                                                      |
| grep   | n     | `<leader>f;`      | Live search for the word under the cursor                                        |
| buffer | n     | `<leader>b`       | Search an opened buffer                                                          |
| buffer | n     | `<leader>m`       | Search recent files (MRU)                                                        |
| help   | n     | `<leader>H`       | Search in Neovim help                                                            |
| symbol | n, v  | `<leader>:`       | Insert Nerd Fonts symbol                                                         |
| symbol | i     | `<C-x>:`          | Complete Nerd Fonts symbol                                                       |

*Mode legend:
- `i`: insert mode
- `n`: normal mode
- `v`: visual mode



