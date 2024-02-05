# -----------------------------------------------------------------------------
# Makefile for macOS
# -----------------------------------------------------------------------------

define MSG_UPDATE_SHELLS

$(PURPLE)In order to add zsh to list of acceptable shells,
please execute the following commands:$(RESET)
$(WHITE)
	sudo -s
	sudo echo $$(brew --prefix)/bin/zsh >> /etc/shells
	exit
$(RESET)
$(PURPLE)In order to use zsh as default shell,
please execute the following commands:$(RESET)
$(WHITE)
	chsh -s $$(brew --prefix)/bin/zsh
$(RESET)
endef

# Checks that zsh (brew version) is in the acceptable shells list.
zsh-check: export MSG_UPDATE_SHELLS := $(MSG_UPDATE_SHELLS)
zsh-check:
	@[ $$SHELL = "$$(brew --prefix)/bin/zsh" ] && \
		($(GNU_GREP) -qx $$(brew --prefix)/bin/zsh /etc/shells || echo "$$MSG_UPDATE_SHELLS")
.PHONY: zsh-check

# Activate zsh as default shell.
zsh-activate:
	command -v zsh | sudo tee -a /etc/shells
	chsh -s $$(brew --prefix)/bin/zsh
.PHONY: zsh-activate

# -----------------------------------------------------------------------------
# Target: Setup macOS device.
# -----------------------------------------------------------------------------

setup:: setup-brew
.PHONY: setup

install:: install-packages-homebrew
.PHONY: install

cleanup::
	@$(call cmd_exists,brew) && brew $(_DRY_RUN) cleanup
.PHONY: cleanup

## Install Homebrew and your packages.
setup-brew:
	@$(MAKE) brew-download
	@${INSTALL} grep go kitty rust zsh
	@$(MAKE) install-stow
	@$(MAKE) setup-links
	@$(MAKE) install-packages-homebrew
	@$(MAKE) postinstall-packages-homebrew
	@$(MAKE) update-packages-homebrew
.PHONY: setup-brew

# Download Homebrew the first time.
brew-download:
	@echo "$(PURPLE)• Downloading and install Homebrew if needed$(RESET)"
	@$(call cmd_exists,brew) || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
.PHONY: brew-download

## Install Homebrew packages.
install-packages-homebrew:
	@echo "$(PURPLE)• Installing Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(BREWFILE)
.PHONY: brew-install

# Run Homebrew post-install tasks.
postinstall-packages-homebrew:
	@echo "$(PURPLE)• Running Homebrew post-install$(RESET)"
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@gem update --system --no-document
.PHONY: brew-postinstall

## Update Homebrew packages.
update-packages-homebrew:
	@echo "$(PURPLE)• Updating Homebrew packages$(RESET)"
	@brew update
	@brew upgrade
	@$(MAKE) brew-postinstall
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