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
endef

# Checks that zsh (brew version) is in the acceptable shells list.
zsh-check: export MSG_UPDATE_SHELLS := $(MSG_UPDATE_SHELLS)
zsh-check:
	@[ $$SHELL = "$$(brew --prefix)/bin/zsh" ] && \
		(grep -qx $$(brew --prefix)/bin/zsh /etc/shells || echo "$$MSG_UPDATE_SHELLS")

# -----------------------------------------------------------------------------
# Target: main
# -----------------------------------------------------------------------------

.PHONY: install

## Install all the prerequisites and perform installation of Homebrew.
install: install-dirs install-links brew
	@echo '$(GREEN)Next target to run:$(RESET)'
	@echo ''
	@echo '$(YELLOW)make neovim$(RESET)'
	@echo ''

# -----------------------------------------------------------------------------
# Target: tree structure
# -----------------------------------------------------------------------------

.PHONY: install-dirs

ENSURE_DIRS = $(XDG_CACHE_HOME)/nvim/backup \
			  $(XDG_CACHE_HOME)/nvim/ctrlp/dir \
			  $(XDG_CACHE_HOME)/nvim/ctrlp/hist \
			  $(XDG_CACHE_HOME)/nvim/ctrlp/mru \
			  $(XDG_CACHE_HOME)/nvim/swap \
			  $(XDG_CACHE_HOME)/nvim/undo \
			  $(XDG_CACHE_HOME)/zplug \
			  $(XDG_CACHE_HOME)/zsh \
			  $(XDG_CONFIG_HOME)/zplug \
			  $(XDG_DATA_HOME)/git \
			  $(XDG_DATA_HOME)/nvim/bundle \
			  $(XDG_DATA_HOME)/nvim/shada \
			  $(XDG_DATA_HOME)/nvim/swap \
			  $(XDG_DATA_HOME)/nvim/undo \
			  $(XDG_DATA_HOME)/nvim/view \
			  $(XDG_DATA_HOME)/tmux \
			  $(XDG_DATA_HOME)/z \
			  $(XDG_DATA_HOME)/zplug \
			  $(XDG_DATA_HOME)/zsh

## Creates the dotfiles tree structure.
install-dirs: $(ENSURE_DIRS)

$(ENSURE_DIRS):
	mkdir -p $@

# -----------------------------------------------------------------------------
# Target: symlinks
# -----------------------------------------------------------------------------

.PHONY: install-links link-home link-dirs unlink-all unlink-home unlink-dirs

DOTFILES      := $(shell find dot -type f -not -name '.*') # Flattened structure, excluding hidden files
DEST_DOTFILES := $(addprefix ~/., $(notdir $(DOTFILES)))
LINK_DIRS     := $(XDG_CONFIG_HOME)/git $(XDG_CONFIG_HOME)/zsh $(XDG_DATA_HOME)/bin

## Generates all the symlinks.
install-links: link-home link-dirs $(XDG_CONFIG_HOME)/zplug/packages.zsh

## Generates only symlinks in the Home directory.
link-home: $(DEST_DOTFILES)

## Generates symlinks of directories
link-dirs: $(LINK_DIRS) $(XDG_CONFIG_HOME)/nvim

## Deletes all the symlinks.
unlink-all: unlink-home unlink-dirs
	rm -f $(XDG_CONFIG_HOME)/zplug/packages.zsh

## Deletes symlinks in the Home directory.
unlink-home:
	rm -f $(DEST_DOTFILES)

## Deletes symlinks of directories
unlink-dirs:
	rm -rf $(LINK_DIRS) $(XDG_CONFIG_HOME)/nvim

$(DEST_DOTFILES): | $(ENSURE_DIRS)
	ln -s $(realpath $(filter %/$(shell echo $(notdir $@) | sed 's/^\.//'), $(DOTFILES))) $@

$(LINK_DIRS):
	ln -s $(realpath $(notdir $@)) $@

$(XDG_CONFIG_HOME)/nvim: | $(ENSURE_DIRS)
	ln -s $(realpath vim) $@

$(XDG_CONFIG_HOME)/zplug/packages.zsh: | $(ENSURE_DIRS)
	ln -s $(realpath zsh/packages.zsh) $@

# -----------------------------------------------------------------------------
# Target: Homebrew
# -----------------------------------------------------------------------------

.PHONY: brew brew-download brew-install brew-postinstall

## Install Homebrew and your packages.
brew: brew-download brew-install brew-postinstall

# Download Homebrew the first time.
brew-download:
	@echo '$(YELLOW)Download Homebrew if necessary…$(RESET)'
	@$(call cmd_exists,brew) && exit 0 || \
		/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install Homebrew packages.
brew-install:
	@echo '$(YELLOW)Install Homebrew packages…$(RESET)'
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(realpath Brewfile)

# Run Homebrew post-install tasks.
brew-postinstall: zsh-check
	@echo '$(YELLOW)Run Homebrew post-install…$(RESET)'
	@pip2 install --upgrade pip setuptools wheel
	@pip3 install --upgrade pip setuptools wheel
	@gem update --system --no-document
	@$(call cmd_exists,fzf) && $$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

# -----------------------------------------------------------------------------
# Target: Neovim
# -----------------------------------------------------------------------------

.PHONY: neovim neovim-update neovim-dependencies neovim-plugins

neovim-dependencies: GEM_COMMAND = $(shell gem list --silent -i neovim && echo 'update' || echo 'install')

## Update the Neovim environment.
neovim: neovim-update neovim-dependencies neovim-plugins
	nvim +checkhealth

## Updates Neovim from Homebrew.
neovim-update:
	brew upgrade --fetch-HEAD neovim

## Updates Neovim's plugins.
neovim-plugins:
	nvim +PlugInstall +PlugUpdate +qa
	tmp_file=$$(mktemp -t dotfiles); mv $$tmp_file "$${tmp_file}.ts" && tmp_file="$${tmp_file}.ts" && \
		nvim $$tmp_file +UpdateRemotePlugins +qa && \
		rm -f $$tmp_file

## Updates Neovim dependencies.
neovim-dependencies:
	@npm install -g neovim --no-progress
	@pip2 install --upgrade neovim
	@pip3 install --upgrade neovim
	@gem $(GEM_COMMAND) neovim --no-document

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
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  $(YELLOW)%-$(TARGET_MAX_CHAR_NUM)s$(RESET) $(GREEN)%s$(RESET)\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)