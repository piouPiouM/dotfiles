install-neovim::
	@brew install -q luajit luajit-openresty luarocks
	@brew install -q --HEAD utf8proc || exit 0
	@brew install -q --HEAD tree-sitter || exit 0
	@brew install -q --HEAD neovim || exit 0
	@$(MAKE) postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@brew install -q lua-language-server
.PHONY: install-neovim-dependencies

update-neovim::
	@brew upgrade -q luajit luajit-openresty luarocks
	@brew upgrade -q --fetch-HEAD utf8proc || exit 0
	@brew upgrade -q --fetch-HEAD tree-sitter || exit 0
	@brew upgrade -q --fetch-HEAD neovim || exit 0
	@$(MAKE) postinstall-neovim
.PHONY: update-neovim

update-neovim-dependencies::
	@brew upgrade -q lua-language-server
.PHONY: update-neovim-dependencies