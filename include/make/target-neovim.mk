# -----------------------------------------------------------------------------
# Target: install Neovim
# -----------------------------------------------------------------------------

NVIM := nvim "+set nomore"

## Setup Neovim environment.
setup-neovim: neovim-treesitter install-neovim neovim-dependencies neovim-packer
	@$(NVIM) +checkhealth
.PHONY: setup-neovim

neovim-treesitter:
	@$(NVIM) "+TSUninstall all" +qa
.PHONY: neovim-treesitter

## Install or update Neovim nightly.
install-neovim:: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Installing Neovim$(RESET)"
.PHONY: install-neovim

postinstall-neovim: install-neovim-dependencies
	@echo "$(PURPLE)• Running Neovim post-installation$(RESET)"
	@$(MAKE) --silent install-neovim-plugins
	@$(NVIM) +UpdateRemotePlugins +qa
.PHONY: postinstall-neovim

## Install or update Neovim dependencies.
install-neovim-dependencies::
	@echo "$(PURPLE)• Installing Neovim dependencies$(RESET)"
	@$(MAKE) --silent install-neovim-thirdparty-dependencies
.PHONY: install-neovim-dependencies

install-neovim-thirdparty-dependencies:: GEM_COMMAND = $(shell gem list --silent -i neovim && echo 'update' || echo 'install')
install-neovim-thirdparty-dependencies:
	@npm install -g neovim@latest --no-progress
	@pip3 install --upgrade pynvim neovim
	@gem $(GEM_COMMAND) neovim --no-document
	@go install github.com/mattn/efm-langserver@latest
.PHONY: install-neovim-thirdparty-dependencies

## Install or reinstall Neovim plugins.
install-neovim-plugins:
	@echo "$(PURPLE)• Reinstall Neovim plugins$(RESET)"
	@mkdir -p $(XDG_DATA_HOME)/nvim/site/pack/packer
	@rm -rf $(XDG_DATA_HOME)/nvim/site/pack/packer/*
	@rm -f $(XDG_CONFIG_HOME)/nvim/plugin/packer_compiled.lua
	@git clone --depth 1 https://github.com/wbthomason/packer.nvim $(XDG_DATA_HOME)/nvim/site/pack/packer/start/packer.nvim
	@$(NVIM) +PackerInstall +qa
.PHONY: install-neovim-plugins