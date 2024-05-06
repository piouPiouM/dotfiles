# -----------------------------------------------------------------------------
# Target: Install, update, remove applications.
# -----------------------------------------------------------------------------

export GOPATH := $(XDG_DATA_HOME)/go
export GOBIN := $(GOPATH)/bin

## Update all applications.
apps-update-all: UPDATE_TARGETS = $(shell $(GNU_GREP) --perl-regexp --only-matching --no-filename --color=never '^apps-update-\S+(?=:)' $(MAKEFILE_LIST) | uniq)
apps-update-all:
	@$(MAKE) $(UPDATE_TARGETS)
.PHONY: apps-update-all

## Install fzf (Fuzzy finder) from sources.
apps-install-fzf:
	@echo "$(PURPLE)• Installing fzf from sources$(RESET)"
ifeq ($(wildcard $(XDG_DATA_HOME)/fzf-repo/.git/.),)
	@git clone --quiet --depth 1 https://github.com/junegunn/fzf.git $(XDG_DATA_HOME)/fzf-repo
else
	@cd $(XDG_DATA_HOME)/fzf-repo && git pull --quiet
endif
	@$(XDG_DATA_HOME)/fzf-repo/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
	@$(GNU_LN) -frs $(XDG_DATA_HOME)/fzf-repo/fzf $(XDG_DATA_HOME)/bin/fzf
	@$(GNU_LN) -frs $(XDG_DATA_HOME)/fzf-repo/fzf-tmux $(XDG_DATA_HOME)/bin/fzf-tmux
.PHONY: apps-install-fzf

## Update fzf (Fuzzy finder).
apps-update-fzf:
	@$(MAKE) apps-install-fzf
.PHONY: apps-update-fzf

## Uninstall fzf (Fuzzy finder).
apps-uninstall-fzf:
	@echo "$(PURPLE)• Uninstalling fzf$(RESET)"
	@$(XDG_CACHE_HOME)/fzf-repo/uninstall --xdg
	@rm -f $(XDG_DATA_HOME)/bin/fzf
	@rm -f $(XDG_DATA_HOME)/bin/fzf-tmux
	@rm -rf $(XDG_DATA_HOME)/fzf-repo
.PHONY: apps-uninstall-fzf

## Setup Python environment.
apps-setup-python: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Setting Python virtual environment$(RESET)"
	@python -m venv $(HOME)/.local/bin/venv
	@$(MAKE) --silent apps-install-python
.PHONY: apps-setup-python

## Backup Python packages.
apps-backup-python:
	@echo "$(PURPLE)• Backuping Python packages$(RESET)"
	@pip freeze > setup/all/packages-python.txt
.PHONY: apps-backup-python

## Install Python packages.
apps-install-python:
	@echo "$(PURPLE)• Restoring Python packages$(RESET)"
	@pip install --requirement setup/all/packages-python.txt
.PHONY: apps-install-python

apps-update-python:
	@echo "$(PURPLE)• Updating Python packages$(RESET)"
	@bin/venv-upgrade
	@$(MAKE) --silent apps-backup-python
.PHONY: apps-update-python

## Install Go applications.
apps-install-go:
	@echo "$(PURPLE)• Installing Go applications$(RESET)"
	@xargs -L 1 go install $(_DRY_RUN) < setup/all/packages-go.txt
.PHONY: apps-install-go

## Update Go applications.
apps-update-go:
	@echo "$(PURPLE)• Updating Go applications$(RESET)"
	@go-global-update || $(call failure,Missing go-global-update command.)
.PHONY: apps-update-go

## Install Lua packages.
apps-install-lua:
	@echo "$(PURPLE)• Installing Lua packages$(RESET)"
	@$(call cmd_exists,luarocks) && luarocks install --local --server=https://luarocks.org/dev luaformatter
.PHONY: apps-install-lua

## Install Rust applications.
apps-install-rust:
	@echo "$(PURPLE)• Installing Rust applications$(RESET)"
	@xargs -L 1 -I {} --no-run-if-empty sh -c 'cargo install --quiet {} && $(call success,{}) || $(call failure,{});' < setup/all/packages-rust.txt
.PHONY: apps-install-rust

## Update Rust applications.
apps-update-rust:
	@echo "$(PURPLE)• Updating Rust applications$(RESET)"
	@cargo install-update -a || $(call failure,Missing cargo-update crate.)
.PHONY: apps-update-rust

## Setup npm environment.
apps-setup-npm: NPM_PACKAGES := $(XDG_DATA_HOME)/npm-packages
apps-setup-npm: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Setting npm global packages into home directory$(RESET)"
	@export NPM_CONFIG_USERCONFIG=$(XDG_CONFIG_HOME)/npm/npmrc
	@touch $$NPM_CONFIG_USERCONFIG
	@npm config set userconfig $$NPM_CONFIG_USERCONFIG
	@npm config set cache $(XDG_CACHE_HOME)/npm
	@npm config set prefix $(NPM_PACKAGES)
	@npm config set fund false
	@npm config set progress false
	@$(call register_manpath,$(NPM_PACKAGES)/share/man)
	@$(MAKE) apps-install-npm
.PHONY: apps-setup-npm

BACKUP_NPM_FILE := setup/npm/packages.txt

## Backup list of global npm packages.
apps-backup-npm: NPM_GLOBAL_ROOT := $(shell command npm root -g)
apps-backup-npm:
	@echo "$(PURPLE)• Backup npm global packages$(RESET)"
	@npm list --global --parseable --depth=0 \
		| $(GNU_SED) "1d;s:^$(NPM_GLOBAL_ROOT)/::" \
		| $(GNU_GREP) -v '^npm$$' \
		> $(BACKUP_NPM_FILE) \
		&& echo "  $(SUCCESS)$$(cat $(BACKUP_NPM_FILE) | wc -l) packages saved" \
		|| echo "  $(FAILURE)No packages to save$(RESET)"
.PHONY: apps-backup-npm

## Install globaly npm packages.
apps-install-npm:
	@echo "$(PURPLE)• Restore npm global packages$(RESET)"
	@xargs npm install --force $(NPM_FLAGS) < $(BACKUP_NPM_FILE)
.PHONY: apps-install-npm

## Update globaly all npm packages.
apps-update-npm:
	@echo "$(PURPLE)• Update npm global packages$(RESET)"
	@xargs npm update $(NPM_FLAGS) < $(BACKUP_NPM_FILE)
.PHONY: apps-update-npm

## Install pnpm environment.
apps-install-pnpm:
	@pnpm add -g @pnpm/tabtab
	@pnpm install-completion zsh
.PHONY: apps-setup-pnpm