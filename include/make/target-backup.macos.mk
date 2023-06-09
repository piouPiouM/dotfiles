# -----------------------------------------------------------------------------
# Target: backup macOS settings
# -----------------------------------------------------------------------------

## Backup Homebrew packages.
backup-brew:
	@echo "$(PURPLE)• Backup Homebrew packages$(RESET)"
	@$(call cmd_exists,brew) && brew list | grep -Fw pcre2 >/dev/null || brew install pcre2
	@$(call cmd_exists,brew) && $(realpath bin/macos/brew-dump) $(BREWFILE)
.PHONY: backup-brew
