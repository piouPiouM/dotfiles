.NOTPARALLEL:
.DEFAULT_GOAL = help

all: help

# -----------------------------------------------------------------------------
# Configutation
# -----------------------------------------------------------------------------

export XDG_CONFIG_HOME := $(HOME)/.config
export XDG_DATA_HOME   := $(HOME)/.local/share
export XDG_CACHE_HOME  := $(HOME)/.cache

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------

.PHONY: zsh-check

uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

ifeq ($(uname_S),Linux)
	OS_LINUX = Yes
endif

ifeq ($(uname_S),Darwin)
	OS_MACOS = Yes
endif

# https://stackoverflow.com/a/44221541/392725
_n := $(findstring -n,$(firstword -$(MAKEFLAGS)))

RED    := $(shell tput -Txterm setaf 1)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

define cmd_exists
	type -a $(1) > /dev/null 2>&1
endef

define MSG_UPDATE_SHELLS

$(YELLOW)In order to add zsh to list of acceptable shells,
please execute the following commands:$(RESET)
$(WHITE)
	sudo -s
	sudo echo $$(brew --prefix)/bin/zsh >> /etc/shells
	exit
$(RESET)
$(YELLOW)In order to use zsh as default shell,
please execute the following commands:$(RESET)
$(WHITE)
	chsh -s $$(brew --prefix)/bin/zsh
$(RESET)
endef

# Checks that zsh (brew version) is in the acceptable shells list.
zsh-check: export MSG_UPDATE_SHELLS := $(MSG_UPDATE_SHELLS)
zsh-check:
	@[ $$SHELL = "$$(brew --prefix)/bin/zsh" ] && \
		(grep -qx $$(brew --prefix)/bin/zsh /etc/shells || echo "$$MSG_UPDATE_SHELLS")

# Activate zsh as default shell.
zsh-activate:
	command -v zsh | sudo tee -a /etc/shells
	chsh -s $$(brew --prefix)/bin/zsh

# -----------------------------------------------------------------------------
# Target: main
# -----------------------------------------------------------------------------

.PHONY: install cleanup versions

## Install all the prerequisites and perform installation of Homebrew.
install: install-dirs install-links brew npm-install-packages
	@echo '$(GREEN)Next target to run:$(RESET)'
	@echo ''
	@echo '$(YELLOW)make neovim$(RESET)'

## Clean all cache systems.
cleanup:
	@brew $(_n) cleanup
	@npm cache verify
	@gem cleanup --silent $(_n)

## Print the version number of main programs.
versions:
	@brew --version
	@echo "$(YELLOW)node$(RESET) $$(node --version)"
	@echo "$(YELLOW)npm$(RESET) $$(npm --version)"
	@ruby --version
	@echo "$(YELLOW)gem$(RESET) $$(gem --version)"

# -----------------------------------------------------------------------------
# Target: tree structure
# -----------------------------------------------------------------------------

.PHONY: install-dirs

ENSURE_DIRS = $(XDG_DATA_HOME)/nvim/bundle \
			  $(XDG_DATA_HOME)/nvim/shada \
			  $(XDG_DATA_HOME)/nvim/swap \
			  $(XDG_DATA_HOME)/nvim/undo \
			  $(XDG_DATA_HOME)/nvim/view \
			  $(XDG_DATA_HOME)/tmux \
			  $(XDG_DATA_HOME)/zoxide \
			  $(XDG_CACHE_HOME)/zsh \
			  ${HOME}/go/bin

## Creates the dotfiles tree structure.
install-dirs: $(ENSURE_DIRS)

$(ENSURE_DIRS):
	mkdir -p $@

# -----------------------------------------------------------------------------
# Target: symlinks
# -----------------------------------------------------------------------------

.PHONY: install-links link-home link-dirs link-lf unlink-all unlink-home unlink-dirs

## Generates all the symlinks.
install-links: link-bash \
	link-bat \
	link-bin \
	link-broot \
	link-environment \
	link-git \
	link-home \
	link-kitty \
	link-lf \
	link-neovim \
	link-ranger \
	link-ripgrep \
	link-rofi \
	link-sway \
	link-zsh \

## Generates only symlinks in the Home directory.
link-home:
	@echo -n '$(YELLOW)Link home environment…$(RESET)'
	@stow --dotfiles dot && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install environment configutation
link-environment:
	@echo -n '$(YELLOW)Link environment…$(RESET)'
	@stow environment && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install zsh environment
link-zsh:
	@echo -n '$(YELLOW)Link zsh environment…$(RESET)'
	@stow zsh && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install bash environment
link-bash:
	@echo -n '$(YELLOW)Link bash environment…$(RESET)'
	@stow bash && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install git environment
link-git:
	@echo -n '$(YELLOW)Link git environment…$(RESET)'
	@stow git && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install ripgrep environment
link-ripgrep:
	@echo -n '$(YELLOW)Link ripgrep environment…$(RESET)'
	@stow ripgrep && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install neovim environment
link-neovim:
	@echo -n '$(YELLOW)Link neovim environment…$(RESET)'
	@stow nvim && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install kitty environment
link-kitty:
	@echo -n '$(YELLOW)Link kitty environment…$(RESET)'
	@stow kitty && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install lf environment
link-lf:
	@echo -n '$(YELLOW)Link lf environment…$(RESET)'
	@stow lf && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install bat environment
link-bat:
	@echo -n '$(YELLOW)Link bat environment…$(RESET)'
	@stow bat && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install broot environment
link-broot:
	@echo -n '$(YELLOW)Link broot environment…$(RESET)'
	@stow broot && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install ranger environment
link-ranger:
	@echo -n '$(YELLOW)Link ranger environment…$(RESET)'
	@stow ranger && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

link-bin:
	@echo -n '$(YELLOW)Link binaries…$(RESET)'
	@mkdir -p $(XDG_DATA_HOME)/bin
	@stow --target=$(XDG_DATA_HOME)/bin bin && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install Sway environment
link-sway:
	@echo -n '$(YELLOW)Link sway environment…$(RESET)'
	@stow sway && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Install Rofi environment
link-rofi:
	@echo -n '$(YELLOW)Link rofi environment…$(RESET)'
	@stow rofi && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

## Deletes all the symlinks.
unlink-all: unlink-home unlink-dirs

## Deletes symlinks in the Home directory.
unlink-home:
	@stow --dotfiles --delete dot

unlink-bin:
	@stow --target=$(XDG_DATA_HOME)/bin --delete bin

# -----------------------------------------------------------------------------
# Target: Downloads
# -----------------------------------------------------------------------------

bin/vim-profiler:
	@curl --silent --create-dirs -o $@ "https://raw.githubusercontent.com/bchretien/vim-profiler/master/vim-profiler.py"
	@chmod +x $@

bin/imgcat:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/imgcat"
	@chmod +x $@

bin/imgls:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/imgls"
	@chmod +x $@

ranger/.config/ranger/devicons.py ranger/.config/ranger/plugins/devicons_linemode.py:
	@curl --silent -o $@ "https://raw.githubusercontent.com/alexanderjeurissen/ranger_devicons/master/$(notdir $@)"

${XDG_CACHE_HOME}/zim/zimfw.zsh:
	@curl -fsSL --create-dirs -o $@ "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"

theme-catppuccin:
	@echo '$(YELLOW)Download Catppuccin for Kitty$(RESET)'
	@curl --silent -o "./kitty/.config/kitty/themes/Catppuccin.conf" "https://raw.githubusercontent.com/catppuccin/kitty/main/catppuccin.conf"
	@echo '$(YELLOW)Download Catppuccin for Rofi$(RESET)'
	@curl --silent --output-dir $(XDG_CONFIG_HOME)/rofi/ --remote-name "https://raw.githubusercontent.com/catppuccin/rofi/main/.config/rofi/config.rasi"
	@curl --silent --output-dir $(XDG_DATA_HOME)/rofi/themes/ --remote-name "https://raw.githubusercontent.com/catppuccin/rofi/main/.local/share/rofi/themes/catppuccin.rasi"

# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

.PHONY: install-fonts codeicon nerd-fonts

FONTS_DIR = $(XDG_DATA_HOME)/fonts
FONTS_IA = $(FONTS_DIR)/iAWriterQuattroS-Bold.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-BoldItalic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Italic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Regular.ttf

## Download and install fonts
install-fonts: codicon nerd-fonts $(FONTS_IA)
	ifdef OS_LINUX
		@fc-cache -f $(FONTS_DIR)
	endif

$(FONTS_IA):
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Quattro/Static/$(notdir $@)"

codicon:
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf"

nerd-fonts:
	@curl -fsSL --create-dirs -o $(FONTS_DIR)/SymbolsNerdFontComplete-2048-em.ttf "https://github.com/ryanoasis/nerd-fonts/raw/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf"

# -----------------------------------------------------------------------------
# Target: Homebrew
# -----------------------------------------------------------------------------

ifdef OS_MACOS
.PHONY: brew brew-download brew-dump brew-install brew-postinstall brew-upgrade

## Install Homebrew and your packages.
brew: brew-download brew-install brew-postinstall brew-upgrade

# Download Homebrew the first time.
brew-download:
	@echo '$(YELLOW)Download Homebrew if necessary…$(RESET)'
	@$(call cmd_exists,brew) && exit 0 || \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## Dump Homebrew packages.
brew-dump:
	@echo '$(YELLOW)Dump Homebrew packages…$(RESET)'
	@$(call cmd_exists,brew) && brew bundle dump --force --file=$(realpath Brewfile) && git restore --staged -- $(realpath Brewfile)

## Install Homebrew packages.
brew-install:
	@echo '$(YELLOW)Install Homebrew packages…$(RESET)'
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(realpath Brewfile)

# Run Homebrew post-install tasks.
brew-postinstall:
	@echo '$(YELLOW)Run Homebrew post-install…$(RESET)'
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@update_rubygems
	@gem update --system --no-document
	@$(call cmd_exists,fzf) && $(MAKE) fzf-postinstall

## Update Homebrew packages.
brew-upgrade:
	@brew update
	@brew upgrade
	@$(call cmd_exists,fzf) && $(MAKE) fzf-update
	@$(MAKE) brew-postinstall
endif

# -----------------------------------------------------------------------------
# Target: npm
# -----------------------------------------------------------------------------

.PHONY: npm-save-packages npm-install-packages

## Backup list of global npm packages.
npm-save-packages:
	@npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$$1); print}' > ./npm/global-packages.txt

## Install globaly all npm packages.
npm-install-packages:
	@xargs npm install --global < ./npm/global-packages.txt

# -----------------------------------------------------------------------------
# Target: Neovim
# -----------------------------------------------------------------------------

.PHONY: neovim neovim-update neovim-dependencies neovim-plugins

neovim-dependencies: GEM_COMMAND = $(shell gem list --silent -i neovim && echo 'update' || echo 'install')

## Update the Neovim environment.
neovim: neovim-update neovim-dependencies neovim-plugins
	@nvim +checkhealth

## Updates Neovim from Homebrew.
neovim-update: | $(ENSURE_DIRS)
	@brew upgrade --fetch-HEAD neovim || exit 0

## Updates Neovim's plugins.
neovim-plugins:
	@nvim +PlugInstall +PlugUpdate +qa
	@tmp_file=$$(mktemp -t dotfiles); mv $$tmp_file "$${tmp_file}.ts" && tmp_file="$${tmp_file}.ts" && \
		nvim $$tmp_file +UpdateRemotePlugins +qa && \
		rm -f $$tmp_file

## Updates Neovim dependencies.
neovim-dependencies:
	@npm install -g neovim --no-progress
	@pip3 install --upgrade pynvim neovim
	@gem $(GEM_COMMAND) neovim --no-document

# -----------------------------------------------------------------------------
# Target: applications
# -----------------------------------------------------------------------------

.PHONY: fzf-postinstall fzf-update lua-install-packages icon-kitty-dark icon-kitty-light lf-dependencies

fzf-postinstall:
	@$$(brew --prefix)/opt/fzf/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
	@nvim "+set nomore" "+PlugUpdate fzf" +qa

## Updates fzf.
fzf-update:
	@$(call cmd_exists,fzf) && brew reinstall fzf || exit 0
	@$(call cmd_exists,fzf) && $(MAKE) fzf-postinstall

lua-install-packages:
ifdef OS_MACOS
	@$(call cmd_exists,luarocks) && brew reinstall luarocks || exit 0
endif
	@$(call cmd_exists,luarocks) && luarocks install --server=https://luarocks.org/dev luaformatter

icon-kitty-dark:
	@cp ./kitty/assets/kitty-dark.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock

icon-kitty-light:
	@cp ./kitty/assets/kitty-light.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock

lf-dependencies:
	@env CGO_ENABLED=1 GO111MODULE=on go get -u github.com/doronbehar/pistol/cmd/pistol

# -----------------------------------------------------------------------------
# Target: usage and help
# credits: https://gist.github.com/prwhite/8168133#gistcomment-2278355
# -----------------------------------------------------------------------------

.PHONY: help

TARGET_MAX_CHAR_NUM := 20

## Print usage and this help message.
help:
	@echo ''
	@echo 'Usage:'
	@echo '  $(YELLOW)make$(RESET) $(GREEN)<target>$(RESET)'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z0-9_-]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  $(YELLOW)%-$(TARGET_MAX_CHAR_NUM)s$(RESET) $(GREEN)%s$(RESET)\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
