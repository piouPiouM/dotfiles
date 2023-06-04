FEDORA_VERSION := $(shell rpm -E %fedora)
INSTALL_FLAGS := -yq --best
INSTALL := sudo dnf $(INSTALL_FLAGS) install
FLATPAK := flatpak install -y --or-update --user

# Used to isolate shell commands from a foreach.
# https://www.extrema.is/blog/2021/12/17/makefile-foreach-commands
define newline


endef

# -----------------------------------------------------------------------------
# Target: Backup
# -----------------------------------------------------------------------------

setup/fedora/copr.txt: backup-dnf-copr
setup/fedora/gnome-extensions.txt: backup-gnome-extensions

## Backup list of enabled Copr repo.
backup-dnf-copr:
	@echo "$(PURPLE)• Backup list of enabled Copr repo$(RESET)"
	@dnf copr list --enabled > setup/fedora/copr.txt
.PHONY: backup-dnf-copr

## Backup list of installed GNOME Extensions.
backup-gnome-extensions:
	@echo "$(PURPLE)• Backup list of installed GNOME Extensions$(RESET)"
	@gext list | grep -Po '(?<=\()(\S+@\S+)(?=\))' > setup/fedora/gnome-extensions.txt
.PHONY: backup-gnome-extensions

# -----------------------------------------------------------------------------
# Target: Setup Linux device. Currently only supports Fedora.
# -----------------------------------------------------------------------------

setup:: setup-hostname setup-dnf setup-zsh setup-packages setup-terminal
.PHONY: setup

setup-battery-management:
	@echo "$(PURPLE)• Setting battery management$(RESET)"
	@$(INSTALL) power-profiles-daemon
	# @$(INSTALL) tlp tlp-rdw smartmontools
	# @sudo systemctl enable tlp # run this
	# @sudo tlp-stat
.PHONY: setup-battery-management

setup-dnf: setup-dnf-config setup-dnf-copr
	@echo "$(PURPLE)• Setting RPM Fusion repositories$(RESET)"
	@$(INSTALL) https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(FEDORA_VERSION).noarch.rpm
	@$(INSTALL) https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(FEDORA_VERSION).noarch.rpm
	@$(INSTALL) rpmfusion-free-release-tainted
.PHONY: setup-dnf

setup-dnf-config: CONF := /etc/dnf/dnf.conf
setup-dnf-config:
	@echo "$(PURPLE)• Setting DNF config$(RESET)"
	@grep -qxF 'fastestmirror=True' $(CONF) || echo 'fastestmirror=True' | sudo tee -a $(CONF) >/dev/null
	@grep -qxF 'max_parallel_downloads=10' $(CONF) || echo 'max_parallel_downloads=10' | sudo tee -a $(CONF) >/dev/null
	@grep -qxF 'deltarpm=True' $(CONF) || echo 'deltarpm=True' | sudo tee -a $(CONF) >/dev/null
	cat $(CONF)
.PHONY: setup-dnf-config

setup-dnf-copr:
	@echo "$(PURPLE)• Setting DNF Copr repo$(RESET)"
	$(foreach REPO,$(shell cat setup/fedora/copr.txt), \
		@sudo dnf $(INSTALL_FLAGS) copr enable $(REPO) $(newline) \
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
	@$(MAKE) --silent install-gnome-extensions
.PHONY: setup-gnome

setup-hostname:
	@echo "$(PURPLE)• Setting hostname$(RESET)"
	@echo -n "$(YELLOW)  Type in your hostname:$(RESET) "
	@read HOSTNAME; \
		hostnamectl set-hostname $$HOSTNAME
.PHONY: setup-hostname

setup-locale-fr:
	@$(INSTALL) langpacks-core-font-fr langpacks-core-fr langpacks-fr
	@$(INSTALL) man-pages-fr
	@$(INSTALL) unspell-filesystem hunspell-fr hyphen-fr
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

## Install CLI and GUI packages.
setup-packages: install-packages-basic install-packages-cli install-packages-gui install-packages-flatpak
.PHONY: setup-packages

## Setup synchronization tools.
setup-sync:
	@$(INSTALL) syncthing
	@systemctl --user enable syncthing
	@systemctl --user start syncthing
.PHONY: setup-sync

setup-terminal: install-fonts install-themes install-starship
	@echo "$(PURPLE)• Setting terminal$(RESET)"
	@$(INSTALL) kitty
.PHONY: setup-terminal

setup-zsh:
	@echo "$(PURPLE)• Setting Zsh$(RESET)"
	@$(INSTALL) zsh
	@echo "$(PURPLE)  Type /usr/bin/zsh in the next prompt$(RESET)"
	@sudo lchsh $$USER
.PHONY: setup-zsh

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
	@$(INSTALL) dnf-plugins-core
	@sudo dnf $(INSTALL_FLAGS) config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
	@sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	@$(INSTALL) brave-browser
.PHONY: install-browser-brave

install-gnome-extensions:
	@echo "$(PURPLE)• Updating or installing GNOME Extensions$(RESET)"
	@pipx install gnome-extensions-cli --system-site-packages
	$(foreach UUID,$(shell cat setup/fedora/gnome-extensions), \
		@gext update --install $(UUID) $(newline) \
	)
.PHONY: install-gnome-extensions

install-neovim::
	@sudo dnf $(INSTALL_FLAGS) copr enable agriffis/neovim-nightly
	@$(INSTALL) lua lua-devel cmake luarocks
	@$(INSTALL) gcc-c++ golang
	@$(INSTALL) libtree-sitter tree-sitter-cli
	@$(INSTALL) neovim python3-neovim
	@$(MAKE) --silent install-neovim-dependencies
	@$(MAKE) --silent postinstall-neovim
.PHONY: install-neovim

install-neovim-dependencies::
	@sudo dnf $(INSTALL_FLAGS) copr enable yorickpeterse/lua-language-server
	@$(INSTALL) lua-language-server
.PHONY: install-neovim-dependencies

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
	@$(MAKE) --silent setup-flatpak-flathub
	@$(INSTALL) git curl wget unzip sqlite
	@$(INSTALL) python3-pip pipx
	@$(INSTALL) cargo golang nodejs-npm rubygems
	@$(INSTALL) stow ripgrep fd-find bat
.PHONY: install-packages-basic

install-packages-cli:
	@echo "$(PURPLE)• Installing CLI packages$(RESET)"
	@$(INSTALL) tealdeer trash-cli
	@$(INSTALL) wev
.PHONY: install-packages-cli

install-packages-gui:
	@echo "$(PURPLE)• Installing GUI packages$(RESET)"
	@$(INSTALL) keepassxc yubikey-manager-qt
.PHONY: install-packages-gui

install-packages-flatpak: APPS := \
	com.spotify.Client \
	com.visualstudio.code \
	com.mattjakeman.ExtensionManager \
	me.kozec.syncthingtk
install-packages-flatpak: install-obsidian
	$(foreach APP_ID,$(APPS), \
		@$(FLATPAK) flathub $(APP_ID) $(newline) \
	)
.PHONY: install-packages-flatpak

install-starship:
	@echo "$(PURPLE)• Installing Starship shell prompt$(RESET)"
	@cargo install starship --locked
.PHONY: install-starship

update-starship:
	@echo "$(PURPLE)• Updating Starship shell prompt$(RESET)"
	@cargo update -p starship
.PHONY: install-starship

install-sway:
	@echo "$(PURPLE)• Installing Sway$(RESET)"
	@$(INSTALL) wayland-devel wayland-protocols-devel
	@$(INSTALL) sway waybar -x alacritty -x swaybar
	@$(INSTALL) sway-config-upstream sway-wallpapers
	@$(INSTALL) wlsunset wob
	@$(INSTALL) azote grimshot playerctl
	@$(INSTALL) brightnessctl
	@sudo dnf copr enable lexa/SwayNotificationCenter
	@$(INSTALL) SwayNotificationCenter
.PHONY: setup-sway

# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

install-fonts::
	@echo "$(PURPLE)• Installing packaged fonts$(RESET)"
	@sudo dnf group install fonts
	@$(INSTALL) \
		adobe-source-code-pro-fonts \
		adobe-source-sans-pro-fonts \
		adobe-source-serif-pro-fonts \
		bitstream-vera-sans-fonts \
		bitstream-vera-serif-fonts \
		dejavu-sans-fonts \
		dejavu-serif-fonts \
		jetbrains-mono-fonts \
		google-carlito-fonts \
		google-noto-emoji-fonts \
		google-roboto-fonts
.PHONY: install-fonts

postinstall-fonts:
	@echo "$(PURPLE)• Installing new downloaded fonts$(RESET)"
	@fc-cache -fr $(FONTS_DIR)
.PHONY: postinstall-fonts
