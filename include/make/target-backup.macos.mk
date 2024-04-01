# -----------------------------------------------------------------------------
# Target: backup macOS settings
# -----------------------------------------------------------------------------

## Backup Homebrew packages.
backup-brew:
	@echo "$(PURPLE)• Backup Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew list | $(GNU_GREP) -Fw pcre2 >/dev/null || brew install pcre2
	@$(call cmd_exists,brew) && $(realpath bin/macos/brew-dump) $(_DRY_RUN) $(BREWFILE) $(COMPAT_PACKAGES) $(REQUIRED_PACKAGES)
.PHONY: backup-brew