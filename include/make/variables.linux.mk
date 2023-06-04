SPECIFIC_TO_LINK = rofi sway
FEDORA_VERSION := $(shell rpm -E %fedora)
INSTALL_FLAGS := -yq --best
INSTALL := sudo dnf $(INSTALL_FLAGS) install
FLATPAK := flatpak install -y --or-update --user
