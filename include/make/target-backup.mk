# -----------------------------------------------------------------------------
# Target: Backup and restore cross-platform settings
# -----------------------------------------------------------------------------

## Backup all settings.
backup: BACKUP_TARGETS = $(shell $(GNU_GREP) --perl-regexp --only-matching --no-filename --color=never '^(?:apps-)?backup-\S+(?=:)' $(MAKEFILE_LIST) | uniq)
backup:
	@$(MAKE) --silent $(BACKUP_TARGETS)
.PHONY: backup