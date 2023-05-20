# -----------------------------------------------------------------------------
# Target: Downloads
# -----------------------------------------------------------------------------

bin/imgcat:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/imgcat"
	@chmod +x $@

bin/imgls:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/imgls"
	@chmod +x $@

# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

.PHONY: postinstall-fonts

postinstall-fonts:
	@cp $(FONTS_DIR)/*.ttf ~/Library/Fonts/

# -----------------------------------------------------------------------------
# Target: Homebrew
# -----------------------------------------------------------------------------

.PHONY: brew brew-download brew-dump brew-install brew-postinstall brew-upgrade

## Install Homebrew and your packages.
brew: brew-download brew-install brew-postinstall brew-upgrade

# Download Homebrew the first time.
brew-download:
	@echo '$(YELLOW)Download Homebrew if necessary…$(RESET)'
	@$(call cmd_exists,brew) && exit 0 || \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## Dump Homebrew packages.
brew-dump:
	@echo '$(YELLOW)Dump Homebrew packages…$(RESET)'
	@$(call cmd_exists,brew) && brew list | grep -Fw pcre2 >/dev/null || brew install pcre2
	@$(call cmd_exists,brew) && $(realpath bin/macos/brew-dump) $(realpath Brewfile)

## Install Homebrew packages.
brew-install:
	@echo '$(YELLOW)Install Homebrew packages…$(RESET)'
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(realpath Brewfile)

# Run Homebrew post-install tasks.
brew-postinstall:
	@echo '$(YELLOW)Run Homebrew post-install…$(RESET)'
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@update_rubygems
	@gem update --system --no-document
	@$(call cmd_exists,fzf) && $(MAKE) fzf-postinstall

## Update Homebrew packages.
brew-upgrade:
	@brew update
	@brew upgrade
	@$(call cmd_exists,fzf) && $(MAKE) fzf-update
	@$(MAKE) brew-postinstall

# -----------------------------------------------------------------------------
# Target: applications
# -----------------------------------------------------------------------------

.PHONY: icon-kitty-dark icon-kitty-light

## Apply a fancy dark icon to Kitty.
icon-kitty-dark:
	@cp ./kitty/assets/kitty-dark.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock

## Apply a fancy light icon to Kitty.
icon-kitty-light:
	@cp ./kitty/assets/kitty-light.icns "$$(mdfind kMDItemCFBundleIdentifier = 'net.kovidgoyal.kitty')/Contents/Resources/kitty.icns"
	@rm /var/folders/*/*/*/com.apple.dock.iconcache
	@killall Dock
