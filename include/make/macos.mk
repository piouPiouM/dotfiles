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

setup:: apps-setup-homebrew
.PHONY: setup

install:: apps-setup-homebrew
.PHONY: install

cleanup::
	@$(call cmd_exists,brew) && brew $(_DRY_RUN) cleanup
.PHONY: cleanup

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