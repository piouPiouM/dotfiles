install-neovim::
	@sudo dnf $(INSTALL_FLAGS) copr enable agriffis/neovim-nightly
	@$(INSTALL) lua lua-devel cmake luarocks
	@$(INSTALL) gcc-c++ golang
	@$(INSTALL) libtree-sitter tree-sitter-cli
	@$(INSTALL) neovim python3-neovim
	@$(MAKE) postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@sudo dnf $(INSTALL_FLAGS) copr enable yorickpeterse/lua-language-server
	@$(INSTALL) lua-language-server
.PHONY: install-neovim-dependencies