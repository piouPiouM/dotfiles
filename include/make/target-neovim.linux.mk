install-neovim::
	@sudo dnf $(INSTALL_FLAGS) copr enable agriffis/neovim-nightly
	@$(INSTALL) lua lua-devel cmake luarocks
	@$(INSTALL) gcc-c++ golang
	@$(INSTALL) libtree-sitter tree-sitter-cli
	@$(INSTALL) neovim python3-neovim
	@$(MAKE) --silent postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@echo "$(PURPLE)  • Installing Lua Language Server$(RESET)"
	@sudo dnf $(INSTALL_FLAGS) copr enable yorickpeterse/lua-language-server
	@$(INSTALL) lua-language-server
.PHONY: install-neovim-dependencies

## Upgrade Neovim environment.
upgrade-neovim:
	@echo "$(PURPLE)• Upgrade Neovim environment after update of the packages$(RESET)"
	@$(MAKE) --silent neovim-treesitter
	@$(MAKE) --silent postinstall-neovim
.PHONY: upgrade-neovim