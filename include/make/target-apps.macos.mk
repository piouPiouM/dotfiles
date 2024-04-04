# -----------------------------------------------------------------------------
# Target: manage macOS applications.
# -----------------------------------------------------------------------------

apps-update-all:: apps-update-homebrew
.PHONY: apps-update-all

## Setup Homebrew environment and install packages.
apps-setup-homebrew:
	@$(MAKE) apps-install-homebrew
	@$(INSTALL) $(COMPAT_PACKAGES)
	@$(INSTALL) $(REQUIRED_PACKAGES)
	@$(MAKE) install-stow
	@$(MAKE) setup-links
	@$(MAKE) apps-install-homebrew-packages
	@$(MAKE) apps-update-homebrew
.PHONY: apps-setup-homebrew

# Download and install Homebrew the first time.
apps-install-homebrew:
	@echo "$(PURPLE)• Downloading and install Homebrew if needed$(RESET)"
	@$(call cmd_exists,brew) || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
.PHONY: apps-install-homebrew

## Install Homebrew packages.
apps-install-homebrew-packages:
	@echo "$(PURPLE)• Installing Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew bundle --no-upgrade --file=$(BREWFILE)
.PHONY: apps-install-homebrew-packages

# Run Homebrew post-install tasks.
apps-postinstall-homebrew-packages:
	@echo "$(PURPLE)• Running Homebrew post-install$(RESET)"
	@brew completions link
	@pip3 install --upgrade pip setuptools wheel
	@gem update --system --no-document
.PHONY: apps-postinstall-homebrew-packages

## Update Homebrew.
apps-update-homebrew:
	@echo "$(PURPLE)• Updating Homebrew packages$(RESET)"
	@brew update
	@brew upgrade
	@$(MAKE) apps-postinstall-homebrew-packages
.PHONY: apps-update-homebrew