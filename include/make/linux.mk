# -----------------------------------------------------------------------------
# Target: Setup Linux device. Currently only supports Fedora.
# -----------------------------------------------------------------------------

setup:: setup-hostname setup-dnf setup-zsh install-stow
	@$(MAKE) setup-links
	@$(MAKE) setup-packages
	@$(MAKE) setup-terminal
.PHONY: setup

## Setup battery management.
setup-battery-management:
	@echo "$(PURPLE)• Setting battery management$(RESET)"
	@$(INSTALL) power-profiles-daemon
	# @$(INSTALL) tlp tlp-rdw smartmontools
	# @sudo systemctl enable tlp # run this
	# @sudo tlp-stat
.PHONY: setup-battery-management

## Setup DNF configuration and repositories.
setup-dnf: setup-dnf-config setup-dnf-copr
	@echo "$(PURPLE)• Setting RPM Fusion repositories$(RESET)"
	@$(INSTALL) https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(FEDORA_VERSION).noarch.rpm
	@$(INSTALL) https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(FEDORA_VERSION).noarch.rpm
	@$(INSTALL) rpmfusion-free-release-tainted
.PHONY: setup-dnf

setup-dnf-config: CONF := /etc/dnf/dnf.conf
setup-dnf-config:
	@echo "$(PURPLE)• Setting DNF config$(RESET)"
	@$(GNU_GREP) -qxF 'fastestmirror=True' $(CONF) || echo 'fastestmirror=True' | sudo tee -a $(CONF) >/dev/null
	@$(GNU_GREP) -qxF 'max_parallel_downloads=10' $(CONF) || echo 'max_parallel_downloads=10' | sudo tee -a $(CONF) >/dev/null
	@$(GNU_GREP) -qxF 'deltarpm=True' $(CONF) || echo 'deltarpm=True' | sudo tee -a $(CONF) >/dev/null
	cat $(CONF)
.PHONY: setup-dnf-config

setup-dnf-copr:
	@echo "$(PURPLE)• Setting DNF Copr repo$(RESET)"
	@$(foreach REPO,$(shell cat setup/linux/fedora/copr.txt),
		sudo dnf $(INSTALL_FLAGS) copr enable $(REPO) $(newline)
	)
.PHONY: setup-dnf-copr

setup-flatpak-flathub:
	@flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	@flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
.PHONY: setup-flatpak-flathub

setup-gnome:
	@echo "$(PURPLE)• Setting GNOME$(RESET)"
	@sudo dnf group update core
	@$(INSTALL) gnome-extensions-app gnome-font-viewer
	@$(INSTALL) qt5ct qgnomeplatform-qt5
	@$(MAKE) install-gnome-extensions
.PHONY: setup-gnome

## Setup hostname.
setup-hostname:
	@echo "$(PURPLE)• Setting hostname$(RESET)"
	@echo -n "$(YELLOW)  Type in your hostname:$(RESET) "
	@read HOSTNAME; \
		hostnamectl set-hostname $$HOSTNAME
.PHONY: setup-hostname

setup-locale-fr:
	@$(INSTALL) langpacks-core-font-fr langpacks-core-fr langpacks-fr
	@$(INSTALL) man-pages-fr
	@$(INSTALL) unspell-filesystem hunspell-fr hyphen-fr autocorr-fr
.PHONY: setup-locale-fr

## Setup multimedia capabilities.
# https://rpmfusion.org/Howto/Multimedia
setup-multimedia-codec:
	@echo "$(PURPLE)• Installing multimedia codecs$(RESET)"
	@sudo dnf config-manager --set-enabled fedora-cisco-openh264
	@sudo dnf swap ffmpeg-free ffmpeg --allowerasing
	@sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
	@sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
	@sudo dnf group update multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	@$(INSTALL) totem
	@$(INSTALL) mozilla-openh264
	@$(INSTALL) mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
	@$(INSTALL) lame\* --exclude=lame-devel
	@$(INSTALL) libdvdcss
	@echo "$(PURPLE)  • Installing Hardware Accelerated Codec for Intel$(RESET)"
	@$(INSTALL) intel-media-driver
.PHONY: setup-multimedia-codec

## Install all packages.
setup-packages: install-packages-basic install-packages-cli install-packages-gui install-packages-flatpak
.PHONY: setup-packages

## Setup synchronization tools.
setup-sync:
	@$(INSTALL) syncthing
	@systemctl --user enable syncthing
	@systemctl --user start syncthing
.PHONY: setup-sync

## Setup terminal application.
setup-terminal:
	@echo "$(PURPLE)• Setting terminal$(RESET)"
	@$(MAKE) install-fonts install-themes install-starship link-kitty
	@$(INSTALL) kitty
.PHONY: setup-terminal

setup-zsh:
	@echo "$(PURPLE)• Setting Zsh as default shell$(RESET)"
	@$(INSTALL) zsh zoxide
	@echo "$(PURPLE)  🛈 Type /usr/bin/zsh in the next prompt$(RESET)"
	@sudo lchsh $$USER
.PHONY: setup-zsh

# -----------------------------------------------------------------------------
# Target: Upgrade system
# -----------------------------------------------------------------------------

## Perform an offline upgrade of the system.
upgrade-system:
	@echo "$(PURPLE)• Starting download of updates$(RESET)"
	@sudo dnf -yq offline-upgrade download
	@echo "$(PURPLE)• Installing, computer will reboot$(RESET)"
	@sudo dnf offline-upgrade reboot
.PHONY: update-system

# -----------------------------------------------------------------------------
# Target: Applications
# -----------------------------------------------------------------------------

## Install Web browsers.
install-browser: install-browser-firefox install-browser-brave
.PHONY: install-browser

install-browser-firefox:
	@echo "$(PURPLE)• Installing Firefox$(RESET)"
	@$(INSTALL) firefox firefox-langpacks
.PHONY: install-browser

install-browser-brave:
	@echo "$(PURPLE)• Installing Brave$(RESET)"
	@$(INSTALL) dnf-plugins-core
	@sudo dnf $(INSTALL_FLAGS) config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
	@sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	@$(INSTALL) brave-browser
.PHONY: install-browser-brave

## Install or update GNOME Shell Extensions.
install-gnome-extensions:
	@echo "$(PURPLE)• Updating or installing GNOME Shell Extensions$(RESET)"
	@pipx install gnome-extensions-cli --system-site-packages
	@$(foreach UUID,$(shell cat setup/linux/fedora/gnome-extensions.txt),
		gext update --install $(UUID) $(newline)
	)
.PHONY: install-gnome-extensions

## Install or update Obsidian.
install-obsidian: APP_ID := md.obsidian.Obsidian
install-obsidian: setup-flatpak-flathub
	@echo "$(PURPLE)• Installing Obsidian$(RESET)"
	@$(FLATPAK) flathub $(APP_ID)
	@flatpak override --user --env=OBSIDIAN_USE_WAYLAND=1 $(APP_ID)
	@echo "$(YELLOW)  Use the following command to launch Obsidian the first time:$(RESET)"
	@echo "$(WHITE)    flatpak run $(APP_ID)$(RESET)"
.PHONY: install-obsidian

install-packages-basic:
	@echo "$(PURPLE)• Setting basic packages$(RESET)"
	@$(INSTALL) fedora-workstation-repositories fedora-flathub-remote fedora-third-party
	@$(INSTALL) flatpak flatseal
	@$(MAKE) setup-flatpak-flathub
	@$(INSTALL) git curl wget unzip sqlite
	@$(INSTALL) python3-pip pipx
	@$(INSTALL) cargo golang nodejs-npm rubygems
.PHONY: install-packages-basic

## Install CLI packages.
install-packages-cli:
	@echo "$(PURPLE)• Installing CLI packages$(RESET)"
	@xargs $(INSTALL) < setup/linux/fedora/packages-cli.txt
.PHONY: install-packages-cli

## Install GUI packages.
install-packages-gui:
	@echo "$(PURPLE)• Installing GUI packages$(RESET)"
	@xargs $(INSTALL) < setup/linux/fedora/packages-gui.txt
.PHONY: install-packages-gui

## Install Flatpak applications.
install-packages-flatpak: install-obsidian
	@echo "$(PURPLE)• Installing Flatpak applications$(RESET)"
	@xargs $(FLATPAK) flathub < setup/linux/fedora/packages-flatpak.txt
.PHONY: install-packages-flatpak

## Install Starship shell prompt.
install-starship:
	@echo "$(PURPLE)• Installing Starship shell prompt$(RESET)"
	@cargo install starship --locked
.PHONY: install-starship

## Update Starship shell prompt.
update-starship:
	@echo "$(PURPLE)• Updating Starship shell prompt$(RESET)"
	@cargo update -p starship
.PHONY: install-starship

## Install Sway window manager.
install-sway:
	@echo "$(PURPLE)• Installing Sway$(RESET)"
	@sudo dnf copr enable lexa/SwayNotificationCenter
	@xargs $(INSTALL) < setup/linux/fedora/packages-sway.txt
.PHONY: setup-sway