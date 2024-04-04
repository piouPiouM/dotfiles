SPECIFIC_TO_LINK := rofi sway

GNU_LN := ln
GNU_SED := sed
GNU_GREP := grep

FEDORA_VERSION := $(shell rpm -E %fedora)
INSTALL_FLAGS := -yq --best
INSTALL := sudo dnf $(INSTALL_FLAGS) install
FLATPAK := flatpak install -y --or-update --user