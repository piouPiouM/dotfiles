# -----------------------------------------------------------------------------
# Target: manage macOS applications.
# -----------------------------------------------------------------------------

## Setup Homebrew environment and install packages.
apps-setup-homebrew:
	@$(MAKE) apps-install-homebrew
	@$(INSTALL) $(COMPAT_PACKAGES)
	@$(INSTALL) $(REQUIRED_PACKAGES)
	@$(MAKE) install-stow
	@$(MAKE) setup-links
	@$(MAKE) --silent apps-download-install-homebrew
	@$(MAKE) --silent apps-install-homebrew
	@$(MAKE) --silent apps-postinstall-homebrew
.PHONY: apps-setup-homebrew

# Download and install Homebrew the first time.
apps-download-install-homebrew:
	@echo "$(PURPLE)• Downloading and install Homebrew if needed$(RESET)"
	@$(call cmd_exists,brew) || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
.PHONY: apps-download-install-homebrew

## Install Homebrew packages.
apps-install-homebrew:
	@echo "$(PURPLE)• Installing Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(BREWFILE)
.PHONY: apps-install-homebrew

# Run Homebrew post-install tasks.
apps-postinstall-homebrew:
	@echo "$(PURPLE)• Running Homebrew post-install$(RESET)"
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@gem update --system --no-document
.PHONY: apps-postinstall-homebrew

## Update Homebrew.
apps-update-homebrew:
	@echo "$(PURPLE)• Updating Homebrew packages$(RESET)"
	@brew update
	@brew upgrade
	@$(MAKE) apps-postinstall-homebrew
.PHONY: apps-update-homebrew