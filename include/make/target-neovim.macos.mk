install-neovim::
	@brew upgrade -q luajit luajit-openresty luarocks
	@brew upgrade -q --fetch-HEAD tree-sitter neovim || exit 0
	@$(MAKE) postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@brew upgrade -q lua-language-server
.PHONY: install-neovim-dependencies