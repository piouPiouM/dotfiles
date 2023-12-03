# -----------------------------------------------------------------------------
# Target: backup Linux settings
# -----------------------------------------------------------------------------

BACKUP_DCONF_DIRS := \
	desktop/calendar \
	desktop/datetime \
	desktop/interface \
	desktop/notifications \
	desktop/peripherals \
	meld \
	mutter \
	settings-daemon/plugins/power \
	shell \
	tweaks

## Backup list of enabled Copr repo (see setup-dnf-copr).
backup-dnf-copr:
	@echo "$(PURPLE)• Backup list of enabled Copr repo$(RESET)"
	@dnf copr list --enabled > setup/linux/fedora/copr.txt
.PHONY: backup-dnf-copr

## Backup list of installed Flatpak applications (see install-packages-flatpak).
backup-flatpak: BACKUP_FILE := setup/linux/fedora/packages-flatpak.txt
backup-flatpak:
	@echo "$(PURPLE)• Backup list of installed Flatpak applications$(RESET)"
	@flatpak list --app --columns=application | tail -n +1 | $(GNU_GREP) -v obsidian > $(BACKUP_FILE)
	@echo "  $(SUCCESS)$$(cat $(BACKUP_FILE) | wc -l) applications saved"
.PHONY: backup-flatpak

## Backup GNOME user settings.
backup-gnome-settings:
	@echo "$(PURPLE)• Backup GNOME customized settings$(RESET)"
	@$(foreach DIR,$(BACKUP_DCONF_DIRS),
		dconf dump /org/gnome/$(DIR)/ > setup/linux/gnome/$(subst /,.,$(DIR)).dconf 2>/dev/null \
			&& echo "  $(SUCCESS)setup/linux/gnome/$(subst /,.,$(DIR)).dconf" $(newline)
	)
.PHONY: backup-gnome-settings

## Backup list of installed GNOME Shell Extensions (see install-gnome-extensions).
backup-gnome-extensions: DATA_DIR = "$$XDG_DATA_HOME"/gnome-shell/extensions/
backup-gnome-extensions: BACKUP_FILE := setup/linux/fedora/gnome-extensions.txt
backup-gnome-extensions:
	@echo "$(PURPLE)• Backup list of installed GNOME Extensions$(RESET)"
	@test -d $(DATA_DIR) && command ls $(DATA_DIR) \
		> $(BACKUP_FILE) \
		2> /dev/null \
		&& echo "  $(SUCCESS)$$(cat $(BACKUP_FILE) | wc -l) extensions saved" \
		|| echo "  $(FAILURE)No extensions to save$(RESET)"
.PHONY: backup-gnome-extensions

# -----------------------------------------------------------------------------
# Target: restore Linux settings
# -----------------------------------------------------------------------------

## Restore GNOME user settings.
restore-gnome-settings:
	@echo "$(PURPLE)• Restore GNOME customized settings$(RESET)"
	$(foreach DIR,$(BACKUP_DCONF_DIRS),
		@dconf load /org/gnome/$(DIR)/ < setup/linux/gnome/$(subst /,.,$(DIR)).dconf 2>/dev/null \
			&& echo "  $(SUCCESS)setup/linux/gnome/$(subst /,.,$(DIR)).dconf" $(newline)
	)
.PHONY: restore-gnome-settings
