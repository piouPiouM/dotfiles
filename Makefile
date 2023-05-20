SHELL=/bin/bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL = help
.DELETE_ON_ERROR:
.NOTPARALLEL:
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

all: help
.PHONY: all

# -----------------------------------------------------------------------------
# Configutation
# -----------------------------------------------------------------------------

export XDG_CONFIG_HOME := $(HOME)/.config
export XDG_DATA_HOME   := $(HOME)/.local/share
export XDG_CACHE_HOME  := $(HOME)/.cache

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------

# Use the FORCE rule as dependency to force the execution of the target rule when
# the false prerequisites contain `%` which is interpreted as a literal.
# https://www.gnu.org/software/make/manual/html_node/Force-Targets.html
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
FORCE:
.PHONY: FORCE

.PHONY: zsh-activate zsh-check

uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

ifeq ($(uname_S),Linux)
	OS_LINUX = Yes
endif

ifeq ($(uname_S),Darwin)
	OS_MACOS = Yes
endif

# https://stackoverflow.com/a/44221541/392725
_DRY_RUN := $(findstring -n,$(firstword -$(MAKEFLAGS)))

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
	@echo '$(YELLOW)Next target to run:$(RESET)'
	@echo ''
	@echo '$(GREEN)make neovim$(RESET)'

## Clean all cache systems.
cleanup:
	@brew $(_DRY_RUN) cleanup
	@npm cache verify
	@gem cleanup --silent $(_DRY_RUN)

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

ENSURE_DIRS = \
							$(XDG_DATA_HOME)/nvim/bundle \
							$(XDG_DATA_HOME)/dictionaries \
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
.PHONY: install-dirs

$(ENSURE_DIRS):
	mkdir -p $@

# -----------------------------------------------------------------------------
# Import OS specific variables
# -----------------------------------------------------------------------------

include include/make/$(if OS_MACOS,macos,linux)-variables.mk

# -----------------------------------------------------------------------------
# Target: symlinks
# -----------------------------------------------------------------------------

TO_LINK = bash \
					bat \
					clifm \
					environment \
					fd \
					fzf \
					git \
					kitty \
					lazygit \
					nvim \
					ranger \
					ripgrep \
					zsh \
					$(SPECIFIC_TO_LINK)
LINK_TARGETS = $(addprefix link-,$(TO_LINK))
UNLINK_TARGETS = $(addprefix unlink-,$(TO_LINK))

# The `::` allow to re-declare the target to act as post-processing target.
$(LINK_TARGETS)::
	@echo -n '$(YELLOW)Link $(subst link-,,$(@)) environment…$(RESET)'
	@stow $(_DRY_RUN) --restow $(subst link-,,$(@)) && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'
.PHONY: $(LINK_TARGETS)

## Generates all the symlinks.
install-links: link-bin link-home $(LINK_TARGETS)
.PHONY: install-links

## Generates only symlinks in the Home directory
link-home:
	@echo -n '$(YELLOW)Link home environment…$(RESET)'
	@stow --restow --dotfiles dot && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'
.PHONY: link-home

## Install custom binaries.
link-bin:
	@echo -n '$(YELLOW)Link binaries…$(RESET)'
	@mkdir -p $(XDG_DATA_HOME)/bin
	@stow --restow --target=$(XDG_DATA_HOME)/bin bin && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'
.PHONY: link-bin

link-ranger::
	@pip install --upgrade Pillow
.PHONY: link-ranger

## Deletes all the symlinks.
unlink-all: unlink-home unlink-bin $(UNLINK_TARGETS)
.PHONY: unlink-all

## Delete other symlinks.
$(UNLINK_TARGETS):
	@echo -n "$(YELLOW)Unlink $(subst unlink-,,$(@)) environment…$(RESET)"
	@stow --delete $(subst unlink-,,$(@)) && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'
.PHONY: $(UNLINK_TARGETS)

## Deletes symlinks in the Home directory.
unlink-home:
	@stow --dotfiles --delete dot
.PHONY: unlink-home

## Delete symlink of custom binaries.
unlink-bin:
	@stow --target=$(XDG_DATA_HOME)/bin --delete bin
.PHONY: unlink-bin

# -----------------------------------------------------------------------------
# Target: Downloads
# -----------------------------------------------------------------------------

bin/vim-profiler:
	@curl --silent --create-dirs -o $@ "https://raw.githubusercontent.com/bchretien/vim-profiler/master/vim-profiler.py"
	@chmod +x $@

ranger/.config/ranger/devicons.py ranger/.config/ranger/plugins/devicons_linemode.py:
	@curl --silent -o $@ "https://raw.githubusercontent.com/alexanderjeurissen/ranger_devicons/master/$(notdir $@)"

${XDG_CACHE_HOME}/zim/zimfw.zsh:
	@curl -fsSL --create-dirs -o $@ "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"

$(XDG_DATA_HOME)/dictionaries/fr.wordlist: $(ENSURE_DIRS)
	@echo -n "$(YELLOW)Download French wordlist…$(RESET)"
	@curl --silent --create-dirs --output-dir $(XDG_DATA_HOME)/dictionaries/ --output "fr.wordlist" "https://raw.githubusercontent.com/redacted/XKCD-password-generator/master/xkcdpass/static/fr-corrected.txt" && sed -i '' 's@c/@ç@g' "$(XDG_DATA_HOME)/dictionaries/fr.wordlist" && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

download-dictionaries: $(XDG_DATA_HOME)/dictionaries/fr.wordlist
.PHONY: download-dictionaries

# -----------------------------------------------------------------------------
# Target: Themes
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
# -----------------------------------------------------------------------------

NIGHTFOX_THEME_PATH := "$(XDG_DATA_HOME)/nvim/site/pack/packer/start/nightfox.nvim/extra"

THEME_CATPPUCCIN_BAT := $(XDG_CONFIG_HOME)/bat/themes/catppuccin-frappe.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-latte.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-macchiato.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-mocha.tmTheme

THEME_CATPPUCCIN_LAZYGIT := $(XDG_DATA_HOME)/lazygit/themes/catppuccin-frappe.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-latte.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-macchiato.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-mocha.yml

THEME_CATPPUCCIN_ROFI := $(XDG_DATA_HOME)/rofi/themes/catppuccin-frappe.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-latte.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-macchiato.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-mocha.rasi

THEME_ROSE_PINE_ROFI := $(XDG_DATA_HOME)/rofi/themes/rose-pine.rasi \
												$(XDG_DATA_HOME)/rofi/themes/rose-pine-dawn.rasi \
												$(XDG_DATA_HOME)/rofi/themes/rose-pine-moon.rasi

THEME_ROSE_PINE_FZF := $(XDG_DATA_HOME)/fzf/themes/rose-pine.sh \
											 $(XDG_DATA_HOME)/fzf/themes/rose-pine-dawn.sh \
											 $(XDG_DATA_HOME)/fzf/themes/rose-pine-moon.sh

.PHONY: install-themes theme-catppuccin theme-nightfox theme-rose-pine theme-postinstall

## Install themes for various tools
install-themes: theme-catppuccin theme-nightfox theme-rose-pine

$(THEME_CATPPUCCIN_BAT):
	@echo "$(YELLOW)Download $(@F) for bat$(RESET)"
	@curl --silent --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/bat/main/$(subst catppuccin,Catppuccin,$(@F))" -o $(@F)

$(THEME_CATPPUCCIN_LAZYGIT):
	@echo "$(YELLOW)Download $(@F) for Lazygit$(RESET)"
	@curl --silent --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/lazygit/main/themes/$(subst catppuccin-,,$(@F))" -o $(@F)
	@sed -i '' -e 's/^/  /' -e '1s/^/gui:\n/' $(@)

$(THEME_CATPPUCCIN_ROFI):
ifdef OS_LINUX
	@echo "$(YELLOW)Download $(@F) for Rofi$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/$(@F)"
endif

$(THEME_ROSE_PINE_ROFI):
ifdef OS_LINUX
	@echo "$(YELLOW)Download $(@F) for Rofi$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/rose-pine/rofi/main/$(@F)"
endif

$(THEME_ROSE_PINE_FZF):
	@echo "$(YELLOW)Download $(@F) for fzf$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/rose-pine/fzf/main/dist/$(@F)"
	@sed -i '' 's/FZF_DEFAULT_OPTS/FZF_THEME/' $(@)

## Download Catppuccin theme
theme-catppuccin: | $(THEME_CATPPUCCIN_BAT) $(THEME_CATPPUCCIN_LAZYGIT) $(THEME_CATPPUCCIN_ROFI)
	@$(MAKE) theme-postinstall

## Download Nightfox theme
theme-nightfox:
	@echo "$(YELLOW)Install Nightfox for Kitty from Neovim$(RESET)"
	@cp "$(NIGHTFOX_THEME_PATH)/dawnfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Dawnfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/dayfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Dayfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/duskfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Duskfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nightfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Nightfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nordfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Nordfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/terafox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Terafox.conf"

theme-rose-pine: | $(THEME_ROSE_PINE_FZF) $(THEME_ROSE_PINE_ROFI)
	@$(MAKE) theme-postinstall

theme-postinstall:
	@$(call cmd_exists,bat) && bat cache --build

# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

FONTS_DIR = $(XDG_DATA_HOME)/fonts
FONTS_IA = $(FONTS_DIR)/iAWriterQuattroS-Bold.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-BoldItalic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Italic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Regular.ttf

## Download and install fonts.
install-fonts:: codicon nerd-fonts $(FONTS_IA)
	@$(MAKE) postinstall-fonts
.PHONY: install-fonts 

## Download and install iA Writter QuattroS font.
$(FONTS_IA):
	@echo "$(YELLOW)Download $(@F) font$(RESET)"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Quattro/Static/$(@F)"

## Download and install Codicon font.
codicon:
	@echo "$(YELLOW)Download Codicon font$(RESET)"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf"
.PHONY: codeicon

## Download and install Nerd Fonts.
nerd-fonts:
	@echo "$(YELLOW)Download Nerd Fonts$(RESET)"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf"
.PHONY: nerd-fonts

# -----------------------------------------------------------------------------
# Target: npm
# -----------------------------------------------------------------------------

.PHONY: npm-save-packages npm-install-packages npm-update-packages

NPM_GLOBAL_ROOT := $(shell sh -c 'npm root -g')

## Backup list of global npm packages.
npm-save-packages:
	@npm list --global --parseable | sed '1d' | sed 's:^$(NPM_GLOBAL_ROOT)/::' > ./npm/global-packages.txt

## Install globaly all npm packages.
npm-install-packages:
	@xargs npm install --global < ./npm/global-packages.txt

## Update globaly all npm packages.
npm-update-packages:
	@xargs npm update --global < ./npm/global-packages.txt

# -----------------------------------------------------------------------------
# Target: Neovim
# -----------------------------------------------------------------------------

.PHONY: neovim neovim-update neovim-dependencies neovim-plugins neovim-treesitter neovim-packer

## Update the Neovim environment.
neovim: neovim-treesitter neovim-update neovim-dependencies neovim-packer
	@nvim +checkhealth

## Updates Neovim from Homebrew.
neovim-update: | $(ENSURE_DIRS)
	@brew upgrade luajit luajit-openresty
	@brew upgrade --fetch-HEAD tree-sitter neovim || exit 0

## Updates Neovim's plugins.
neovim-plugins:
	# @nvim +PlugInstall +PlugUpdate +qa
	@tmp_file=$$(mktemp -t dotfiles); mv $$tmp_file "$${tmp_file}.ts" && tmp_file="$${tmp_file}.ts" && \
		nvim $$tmp_file +UpdateRemotePlugins +qa && \
		rm -f $$tmp_file

## Update tree-sitter parsers.
neovim-treesitter:
	@nvim "+TSUninstall all" +qa

neovim-packer:
	@rm -rf $$XDG_DATA_HOME/nvim/site/pack/packer/*
	@git clone --depth 1 https://github.com/wbthomason/packer.nvim $$XDG_DATA_HOME/nvim/site/pack/packer/start/packer.nvim

## Updates Neovim dependencies.
neovim-dependencies: GEM_COMMAND = $(shell gem list --silent -i neovim && echo 'update' || echo 'install')
neovim-dependencies:
	@npm install -g neovim --no-progress
	@pip3 install --upgrade pynvim neovim
	@gem $(GEM_COMMAND) neovim --no-document
	@brew upgrade lua-language-server

# -----------------------------------------------------------------------------
# Target: applications
# -----------------------------------------------------------------------------

.PHONY: fzf-postinstall fzf-update lua-install-packages

fzf-postinstall:
	@$$(brew --prefix)/opt/fzf/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
	@nvim "+set nomore" "+PlugUpdate fzf" +qa

## Updates fzf.
fzf-update:
	@$(call cmd_exists,fzf) && brew reinstall fzf && $(MAKE) fzf-postinstall || exit 0

lua-install-packages:
ifdef OS_MACOS
	@$(call cmd_exists,luarocks) && brew reinstall luarocks || exit 0
endif
	@$(call cmd_exists,luarocks) && luarocks install --server=https://luarocks.org/dev luaformatter

# -----------------------------------------------------------------------------
# Import OS specific targets
# -----------------------------------------------------------------------------

include include/make/$(if OS_MACOS,macos,linux).mk

# -----------------------------------------------------------------------------
# Target: usage and help
# credits: https://gist.github.com/prwhite/8168133#gistcomment-2278355
# -----------------------------------------------------------------------------

.PHONY: help

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
			printf "  $(YELLOW)%-20s$(RESET) $(GREEN)%s$(RESET)\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo ''
	@echo 'Link targets:'
	@printf  '  $(YELLOW)link-%-15s$(RESET) $(GREEN)Create symlinks for %1$$s$(RESET).\n' $(subst link-,,$(LINK_TARGETS))
	@echo ''
	@echo 'Unlink targets:'
	@printf  '  $(YELLOW)unlink-%-13s$(RESET) $(GREEN)Delete symlinks for %1$$s$(RESET).\n' $(subst unlink-,,$(UNLINK_TARGETS))
