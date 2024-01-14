# -----------------------------------------------------------------------------
# Target: install Neovim
# -----------------------------------------------------------------------------

NVIM := nvim "+set nomore"

## Setup Neovim environment.
setup-neovim: neovim-treesitter install-neovim neovim-dependencies neovim-packer
	@$(NVIM) +checkhealth
.PHONY: setup-neovim

neovim-treesitter:
	@echo "$(PURPLE)• Uninstalling all Treesitter parsers$(RESET)"
	@$(NVIM) "+TSUninstall all" +qa
.PHONY: neovim-treesitter

## Install or update Neovim nightly.
install-neovim:: | $(ENSURE_DIRS)
	@echo "$(PURPLE)• Installing Neovim$(RESET)"
.PHONY: install-neovim

postinstall-neovim: install-neovim-dependencies
	@echo "$(PURPLE)• Running Neovim post-installation$(RESET)"
	@$(NVIM) +UpdateRemotePlugins +qa
.PHONY: postinstall-neovim

## Install or update Neovim dependencies.
install-neovim-dependencies::
	@echo "$(PURPLE)• Installing Neovim dependencies$(RESET)"
	@$(MAKE) --silent install-neovim-thirdparty-dependencies
	@echo "$(PURPLE)  • Installing EFM Language Server$(RESET)"
	@go install github.com/mattn/efm-langserver@latest
.PHONY: install-neovim-dependencies

install-neovim-thirdparty-dependencies:: GEM_COMMAND = $(shell gem list --silent -i neovim && echo 'update' || echo 'install')
install-neovim-thirdparty-dependencies:
	@echo "$(PURPLE)• Installing Neovim thirdpary dependencies$(RESET)"
	@echo "$(PURPLE)  • Installing Node.js provider$(RESET)"
	@npm install $(NPM_FLAGS) neovim@latest
	@echo "$(PURPLE)  • Installing Python provider$(RESET)"
	@pip3 install --upgrade pynvim neovim
	@echo "$(PURPLE)  • Installing Ruby provider$(RESET)"
	@gem $(GEM_COMMAND) neovim --no-document
.PHONY: install-neovim-thirdparty-dependencies