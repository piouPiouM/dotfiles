SHELL=/bin/bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
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
	CURRENT_OS := linux
	OS_LINUX := Yes
	OS_MACOS :=
endif

ifeq ($(uname_S),Darwin)
	CURRENT_OS := macos
	OS_LINUX :=
	OS_MACOS := Yes
endif

# https://stackoverflow.com/a/44221541/392725
_DRY_RUN := $(findstring -n,$(firstword -$(MAKEFLAGS)))

RED   := $(shell tput -Txterm setaf 1)
GREEN := $(shell tput -Txterm setaf 2)
# Need interaction
YELLOW := $(shell tput -Txterm setaf 3)
# Information
PURPLE := $(shell tput -Txterm setaf 5)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

SUCCESS := $(GREEN) $(RESET)
FAILURE := $(RED)✗ $(RESET)

# Used to isolate shell commands from a foreach.
# https://www.extrema.is/blog/2021/12/17/makefile-foreach-commands
define newline


endef

define cmd_exists
	type -a $(1) > /dev/null 2>&1
endef

define register_manpath
	grep -qs $(1) $$HOME/.manpath || echo "MANDATORY_MANPATH $(1)" >> $$HOME/.manpath
endef

# -----------------------------------------------------------------------------
# Target: main
# -----------------------------------------------------------------------------

## Perform setup of the device.
setup:: setup-dirs
.PHONY: setup

## Install all the prerequisites.
install:: setup-dirs install-stow setup-links
.PHONY: install

install-stow:
	@echo "$(PURPLE)• Installing GNU Stow$(RESET)"
	@$(INSTALL) stow
.PHONY: install-stow

## Clean all cache systems.
cleanup::
	@npm cache verify
	@gem cleanup --silent $(_DRY_RUN)
	@rm -f $(XDG_DATA_HOME)/$$USER/symbols/nerdfonts.json
.PHONY: cleanup

## Print the version number of main programs.
versions:
	@brew --version
	@echo "$(PURPLE)node$(RESET) $$(node --version)"
	@echo "$(PURPLE)npm$(RESET) $$(npm --version)"
	@ruby --version
	@/usr/local/opt/ruby/bin/ruby --version
	@echo "$(PURPLE)gem$(RESET) $$(gem --version)"
.PHONY: versions

# -----------------------------------------------------------------------------
# Target: tree structure
# -----------------------------------------------------------------------------

ENSURE_DIRS = $(XDG_CACHE_HOME)/gem \
							$(XDG_CACHE_HOME)/less \
							$(XDG_CACHE_HOME)/npm \
							$(XDG_CACHE_HOME)/zsh \
							$(XDG_CONFIG_HOME)/npm \
							$(XDG_DATA_HOME)/cargo \
							$(XDG_DATA_HOME)/dictionaries \
							$(XDG_DATA_HOME)/fonts \
							$(XDG_DATA_HOME)/gem \
							$(XDG_DATA_HOME)/npm-packages \
							$(XDG_DATA_HOME)/nvim/bundle \
							$(XDG_DATA_HOME)/nvim/shada \
							$(XDG_DATA_HOME)/nvim/swap \
							$(XDG_DATA_HOME)/nvim/undo \
							$(XDG_DATA_HOME)/nvim/view \
							$(XDG_DATA_HOME)/tmux \
							$(XDG_DATA_HOME)/zoxide \
							$(HOME)/go/bin

## Creates the dotfiles tree structure.
setup-dirs:
	@echo "$(PURPLE)• Creating directories$(RESET)"
	@$(MAKE) $(ENSURE_DIRS)
.PHONY: setup-dirs

$(ENSURE_DIRS):
	mkdir -p $@

# -----------------------------------------------------------------------------
# Import OS specific variables
# -----------------------------------------------------------------------------

-include include/make/variables.$(CURRENT_OS).mk

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

-include include/make/$(CURRENT_OS).mk
include include/make/target-backup.mk
-include include/make/target-backup.$(CURRENT_OS).mk
include include/make/target-links.mk
include include/make/target-downloads.mk
-include include/make/target-downloads.$(CURRENT_OS).mk
include include/make/target-fonts.mk
-include include/make/target-fonts.$(CURRENT_OS).mk
include include/make/target-fzf.mk
include include/make/target-neovim.mk
-include include/make/target-neovim.$(CURRENT_OS).mk
include include/make/target-themes.mk
-include include/make/target-themes.$(CURRENT_OS).mk

# -----------------------------------------------------------------------------
# Target: applications
# -----------------------------------------------------------------------------

install-packages-lua:
	@$(call cmd_exists,luarocks) && luarocks install --server=https://luarocks.org/dev luaformatter
.PHONY: install-packages-lua

## Setup npm environment.
setup-npm: NPM_PACKAGES := $(XDG_DATA_HOME)/npm-packages
setup-npm: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Setting npm global packages into home directory$(RESET)"
	@export NPM_CONFIG_USERCONFIG=$(XDG_CONFIG_HOME)/npm/npmrc
	@npm config set userconfig $$NPM_CONFIG_USERCONFIG
	@npm config set cache $(XDG_CACHE_HOME)/npm
	@npm config set prefix $(NPM_PACKAGES)
	@$(call register_manpath,$(NPM_PACKAGES)/share/man)
	@$(MAKE) restore-npm
.PHONY: setup-npm

# -----------------------------------------------------------------------------
# Target: usage and help
# credits: https://gist.github.com/prwhite/8168133#gistcomment-2278355
# -----------------------------------------------------------------------------

## Print usage and this help message.
help:
	@echo ''
	@echo "$(GREEN)Dotfiles management on $(CURRENT_OS)$(RESET)."
	@echo ''
	@echo 'Usage:'
	@echo "  $(PURPLE)make$(RESET) $(GREEN)<target>$(RESET)"
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z0-9_-]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "$(PURPLE)%s$(RESET) %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort | column -t -l 2 | $(GNU_SED) "s/^/  /"
	@echo ''
	@echo 'Symlink targets:'
	@printf "  $(PURPLE)[un]%s$(RESET)\n" $(sort $(LINK_TARGETS))
.PHONY: help