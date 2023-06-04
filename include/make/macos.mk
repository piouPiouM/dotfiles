# -----------------------------------------------------------------------------
# Target: Downloads
# -----------------------------------------------------------------------------

bin/imgcat:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/$(@F)"
	@chmod +x $@

bin/imgls:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/$(@F)"
	@chmod +x $@

# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

postinstall-fonts:
	@echo "$(PURPLE)• Installing new fonts$(RESET)"
	@cp $(FONTS_DIR)/*.ttf ~/Library/Fonts/
.PHONY: postinstall-fonts

# -----------------------------------------------------------------------------
# Target: Homebrew
# -----------------------------------------------------------------------------

## Install Homebrew and your packages.
brew: brew-download brew-install brew-postinstall brew-upgrade
.PHONY: brew

# Download Homebrew the first time.
brew-download:
	@echo "$(PURPLE)• Download Homebrew if necessary$(RESET)"
	@$(call cmd_exists,brew) || \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
.PHONY: brew-download

## Dump Homebrew packages.
brew-dump:
	@echo "$(PURPLE)• Dump Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew list | grep -Fw pcre2 >/dev/null || brew install pcre2
	@$(call cmd_exists,brew) && $(realpath bin/macos/brew-dump) $(realpath Brewfile)
.PHONY: brew-dump

## Install Homebrew packages.
brew-install:
	@echo "$(PURPLE)• Install Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(realpath Brewfile)
.PHONY: brew-install

# Run Homebrew post-install tasks.
brew-postinstall:
	@echo "$(PURPLE)• Run Homebrew post-install$(RESET)"
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@update_rubygems
	@gem update --system --no-document
.PHONY: brew-postinstall

## Update Homebrew packages.
brew-upgrade:
	@brew update
	@brew upgrade
	@$(MAKE) --silent brew-postinstall
.PHONY: brew-upgrade

# -----------------------------------------------------------------------------
# Target: Applications
# -----------------------------------------------------------------------------

## Apply a fancy dark icon to Kitty.
icon-kitty-dark:
	@cp ./kitty/assets/kitty-dark.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock
.PHONY: icon-kitty-dark

## Apply a fancy light icon to Kitty.
icon-kitty-light:
	@cp ./kitty/assets/kitty-light.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock
.PHONY: icon-kitty-light

install-neovim::
	@brew install -q luajit luajit-openresty luarocks
	@brew install -q --fetch-HEAD tree-sitter neovim || exit 0
	@$(MAKE) --silent install-neovim-dependencies
	@$(MAKE) --silent postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@brew install -q lua-language-server
.PHONY: install-neovim-dependencies:
