# -----------------------------------------------------------------------------
# Target: Backup and restore cross-platform settings
# -----------------------------------------------------------------------------

BACKUP_NPM_FILE := setup/npm/packages.txt
BACKUP_TARGETS = $(shell $(GNU_GREP) --perl-regexp --only-matching --no-filename --color=never '^backup-\S+(?=:)' $(MAKEFILE_LIST) | uniq)

## Backup all settings.
backup:
	@$(MAKE) --silent $(BACKUP_TARGETS)
.PHONY: backup

## Backup list of global npm packages.
backup-npm: NPM_GLOBAL_ROOT := $(shell command npm root -g)
backup-npm:
	@echo "$(PURPLE)• Backup npm global packages$(RESET)"
	@npm list --global --parseable --depth=0 \
		| $(GNU_SED) "1d;s:^$(NPM_GLOBAL_ROOT)/::" \
		| $(GNU_GREP) -v '^npm$$' \
		> $(BACKUP_NPM_FILE) \
		&& echo "  $(SUCCESS)$$(cat $(BACKUP_NPM_FILE) | wc -l) packages saved" \
		|| echo "  $(FAILURE)No packages to save$(RESET)"
.PHONY: backup-npm

## Install globaly npm packages.
restore-npm:
	@echo "$(PURPLE)• Restore npm global packages$(RESET)"
	@xargs npm install $(NPM_FLAGS) < $(BACKUP_NPM_FILE)
.PHONY: restore-npm

## Update globaly all npm packages.
update-packages-npm:
	@echo "$(PURPLE)• Update npm global packages$(RESET)"
	@xargs npm update $(NPM_FLAGS) < $(BACKUP_NPM_FILE)
	@$(MAKE) --silent backup-npm
.PHONY: restore-update-npm