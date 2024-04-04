# -----------------------------------------------------------------------------
# Target: Install, update, remove applications.
# -----------------------------------------------------------------------------

export GOPATH := $(XDG_DATA_HOME)/go
export GOBIN := $(GOPATH)/bin

## Update all applications.
apps-update-all:: apps-update-fzf apps-update-go apps-update-rust
.PHONY: apps-update-all

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

## Setup npm environment.
setup-npm: NPM_PACKAGES := $(XDG_DATA_HOME)/npm-packages
setup-npm: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Setting npm global packages into home directory$(RESET)"
	@export NPM_CONFIG_USERCONFIG=$(XDG_CONFIG_HOME)/npm/npmrc
	@touch $$NPM_CONFIG_USERCONFIG
	@npm config set userconfig $$NPM_CONFIG_USERCONFIG
	@npm config set cache $(XDG_CACHE_HOME)/npm
	@npm config set prefix $(NPM_PACKAGES)
	@npm config set fund false
	@npm config set progress false
	@$(call register_manpath,$(NPM_PACKAGES)/share/man)
	@$(MAKE) restore-npm
.PHONY: setup-npm

## Setup pnpm environment.
setup-pnpm:
	@pnpm add -g @pnpm/tabtab
	@pnpm install-completion zsh
.PHONY: setup-pnpm

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

## Install fzf (Fuzzy finder) from sources.
apps-install-fzf:
	@echo "$(PURPLE)• Installing fzf from sources$(RESET)"
ifeq ($(wildcard $(XDG_DATA_HOME)/fzf-repo/.git/.),)
	@git clone --quiet --depth 1 https://github.com/junegunn/fzf.git $(XDG_DATA_HOME)/fzf-repo
else
	@cd $(XDG_DATA_HOME)/fzf-repo && git pull --quiet
endif
	@$(XDG_DATA_HOME)/fzf-repo/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
	@$(GNU_LN) -rs $(XDG_DATA_HOME)/fzf-repo/fzf $(XDG_DATA_HOME)/bin/fzf
	@$(GNU_LN) -rs $(XDG_DATA_HOME)/fzf-repo/fzf-tmux $(XDG_DATA_HOME)/bin/fzf-tmux
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