<h3 align="center">
 <img src="https://avatars.githubusercontent.com/u/22614?v=4" width="100" alt="Mehdi Kabab"/><br/>
<br/> 
<a href="https://github.com/piouPiouM">Mehdi Kabab</a>'s dotfiles
</h3>
<p align="center">
  <img src="https://img.shields.io/badge/Linux-fcc624?style=for-the-badge&logo=linux&logoColor=000" alt="GNU/Linux"/>
  <img src="https://img.shields.io/badge/Fedora-51A2DA?style=for-the-badge&logo=Fedora&logoColor=fff" alt="Fedora"/>
  <img src="https://img.shields.io/badge/macOS-000?style=for-the-badge&logo=Apple&logoColor=fff" alt="macOS"/>
</p>

Manage backup, restore, and installation of my environments [since 2011](https://github.com/piouPiouM/dotfiles/commit/ec918b4). Based on the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) and uses [GNU Stow](https://www.gnu.org/software/stow/) to maintain symlinks to my home directory. And mainly to reduce the mess in my `$HOME` 🍺

<figure align="center">

![neovim.png](_assets/neovim.png)
	<figcaption>Neovim at a glance</figcaption>
</figure>

## Contents

As Front-end developer, I am using the CLI in my day-to-day workflow. The tools I use most frequently have their configuration versioned in this repository:

- [Kitty](https://sw.kovidgoyal.net/kitty/) as terminal emulator.
- Zsh as main shell with [zim](https://zimfw.sh/) to manage shell plugins and [Starship](https://starship.rs/) prompt.
- [Neovim](https://neovim.io/) as main editor and visual editor.
- [fzf](https://github.com/junegunn/fzf) as command-line fuzzy finder 🌸
- [Ripgrep](https://github.com/BurntSushi/ripgrep) as search and replace tool.
- [fd](https://github.com/sharkdp/fd) as fast and user-friendly alternative to find.
- [Lazygit](https://github.com/jesseduffield/lazygit) as git Terminal UI (_TUI_).

### Linux

I using Fedora with Wayland, switch between GNOME Desktop Environment and Sway compositor.

- DNF and Flatpak as packages manager.

### macOS

I also use macOS in my daily life.

- Homebrew as packages manager.

## Install

You can start by cloning the repository.

```sh
$ git clone --depth 1 https://github.com/piouPiouM/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
```

> **Note**
> I use `~/.dotfiles` as the destination directory because an alias allows me to directly edit the folder from any location: [`dotfiles`](https://github.com/piouPiouM/dotfiles/blob/ddc85554b0d2e5c9e6a386800612130c2d246e4d/zsh/.config/zsh/plugins/aliases/init.zsh#L16).  

### Fresh operating system installation?

These instructions are for setting up new macOS or Fedora operating system.

```sh
$ make setup
```

> **Warning**  
> It's a WIP target knowing that I'm adding cross-platform support and that I don't reinstall my OS every day 😂

### Install without alter the system?

```sh
$ make install
```

## Local overrides

I use my dotfiles for personal and professional purposes, on distinct devices. Some information, such as my git email address or business scripts, are stored specifically on each machine. To help me, some non-versioned configuration files can be loaded:

- Shell environment: `~/.local/share/zsh/exports.zsh`.
- Git: `~/.local/share/git/config` (copy [local-config.sample](https://github.com/piouPiouM/dotfiles/blob/ddc85554b0d2e5c9e6a386800612130c2d246e4d/git/.local/share/git/local-config.sample)).

---

## Makefile

I heavily use make to automatize my maintenance tasks.  
_Why choosing make?_ Because it's commonly shipped with *nix OS. I can directly launch the setup process without installing anything else.

> **Note**  
> The accessible targets is dynamically created to be conform with the current OS.  
> See [include/make/](./include/make/) directory.

### `make` and `make help`

- Displays a succinct usage message.
- Displays a list of all available targets.

### `make backup`

Saves manually changed or added items in the [`setup`](./setup/) directory:

| What?               | Linux | Fedora | macOS |
| ------------------- |:-----:|:------:|:-----:|
| DNF & Corp Repo     |       | ✅     |       |
| Flatpak apps        | ✅    | ✅     |       |
| GNOME extensions    | ✅    | ✅     |       |
| GNOME settings      | ✅    | ✅     |       |
| Homebrew packages   |       |        | ✅    |
| NPM global packages | ✅    | ✅     | ✅    |

### `make install`

_WIP_

### `make setup`

_WIP_

### `make setup-neovim`

_WIP_

### `make install-fonts`

Launch installation of used font-faces, mainly:

- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) as monospace font.
- [IBM Plex](https://www.ibm.com/plex/) for Obsidian.
- [Nerds Font](https://www.nerdfonts.com/) to enhance my TUI.

> **Note**  
> Symbols of Nerd Fonts are installed by the [`install-fonts-nerd-symbols-only`](https://github.com/piouPiouM/dotfiles/blob/ddc85554b0d2e5c9e6a386800612130c2d246e4d/include/make/target-fonts.mk#L43-L54) target, which also updates the list of symbols in [Kitty's configuration](./kitty/.config/kitty/nerd-fonts.conf) in order to always be up to date 🪄

---

## FAQ

### Error `zsh compinit: insecure directories, run compaudit for list.`

This error may occur when opening a new shell. The following command will certainly solve the problem:

```sh
$ compaudit | xargs chmod g-w
```

### Error `trash: error -1701`

If you get this error when using Kitty, you need to reset the Finder access permissions using the following command. A
confirmation prompt will be displayed the next time you run the `trash` command.

```sh
$ tccutil reset AppleEvents net.kovidgoyal.kitty
```

Thx to [@gsbabil](https://github.com/ali-rantakari/trash/issues/37#issuecomment-1104788438) for the tip!