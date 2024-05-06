# -----------------------------------------------------------------------------
# Target: Install, update, remove applications for Linux.
# -----------------------------------------------------------------------------

## Install Web browsers.
apps-install-browser: apps-install-browser-firefox apps-install-browser-brave
.PHONY: apps-install-browser

apps-install-browser-firefox:
	@echo "$(PURPLE)• Installing Firefox$(RESET)"
	@$(INSTALL) firefox firefox-langpacks
.PHONY: apps-install-browser

apps-install-browser-brave:
	@echo "$(PURPLE)• Installing Brave$(RESET)"
	@$(INSTALL) dnf-plugins-core
	@sudo dnf $(INSTALL_FLAGS) config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
	@sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	@$(INSTALL) brave-browser
.PHONY: apps-install-browser-brave

## Install or update GNOME Shell Extensions.
apps-install-gnome-extensions:
	@echo "$(PURPLE)• Updating or installing GNOME Shell Extensions$(RESET)"
	@pipx install gnome-extensions-cli --system-site-packages
	@$(foreach UUID,$(shell cat setup/linux/fedora/gnome-extensions.txt),
		gext update --install $(UUID) $(newline)
	)
.PHONY: apps-install-gnome-extensions

## Install or update Obsidian.
apps-install-obsidian: APP_ID := md.obsidian.Obsidian
apps-install-obsidian: setup-flatpak-flathub
	@echo "$(PURPLE)• Installing Obsidian$(RESET)"
	@$(FLATPAK) flathub $(APP_ID)
	@flatpak override --user --env=OBSIDIAN_USE_WAYLAND=1 $(APP_ID)
	@echo "$(YELLOW)  Use the following command to launch Obsidian the first time:$(RESET)"
	@echo "$(WHITE)    flatpak run $(APP_ID)$(RESET)"
.PHONY: apps-install-obsidian

## Install Smartgit.
apps-install-smartgit: SMARTGIT_DIR := $(HOME)/.var/app/com.syntevo.SmartGit
apps-install-smartgit: FLATHUB_MANIFEST := https://raw.githubusercontent.com/flathub/com.syntevo.SmartGit/master/com.syntevo.SmartGit.yaml
apps-install-smartgit: DOWNLOAD_PATTERN := (?<=\burl:\s).*smartgit-linux-[\d\.-_]+.tar.gz
apps-install-smartgit: DOWNLOAD_URL := $(shell curl -fsSL $(FLATHUB_MANIFEST) | $(GNU_GREP) --color=never -Po "$(DOWNLOAD_PATTERN)")
apps-install-smartgit: SMARTGIT_VERSION := $(shell echo "$(DOWNLOAD_URL)" | $(GNU_GREP) -Po "[\d\.-_]+(?=.tar)" | tr "_" ".")
apps-install-smartgit: TMP := $(shell mktemp -d)
apps-install-smartgit:
	@echo "$(PURPLE)• Installing Smartgit $(SMARTGIT_VERSION)$(RESET)"
	@trash -f "$(SMARTGIT_DIR)/smartgit"
	@mkdir -p "$(SMARTGIT_DIR)"
	@curl -fsSL --output "$(TMP)/smartgit.tar.gz" "$(DOWNLOAD_URL)"
	@tar xzf "$(TMP)/smartgit.tar.gz" --directory="$(HOME)/.var/app/com.syntevo.SmartGit/"
	@sh "$(SMARTGIT_DIR)/smartgit/bin/add-menuitem.sh"
	@rm -rf $(TMP)
.PHONY: apps-install-smartgit

## Install Sway window manager.
apps-install-sway:
	@echo "$(PURPLE)• Installing Sway$(RESET)"
	@sudo dnf copr enable lexa/SwayNotificationCenter
	@xargs $(INSTALL) < setup/linux/fedora/packages-sway.txt
.PHONY: apps-install-sway

## Install Miniconda 🐍️
apps-install-miniconda: TMP := $(shell mktemp -d)
apps-install-miniconda:
	@echo "$(PURPLE)• Installing Miniconda$(RESET)"
	@mkdir -p "$(HOME)/.local/bin/miniconda"
	@wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $(TMP)/miniconda.sh
	@bash $(TMP)/miniconda.sh -b -u -p "$(HOME)/.local/bin/miniconda"
	@rm -rf $(TMP)
.PHONY: apps-install-miniconda