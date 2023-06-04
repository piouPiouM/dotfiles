install-neovim::
	@brew install -q luajit luajit-openresty luarocks
	@brew install -q --fetch-HEAD tree-sitter neovim || exit 0
	@$(MAKE) --silent postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@brew install -q lua-language-server
.PHONY: install-neovim-dependencies:
