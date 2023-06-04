# -----------------------------------------------------------------------------
# Target: create or delete symlinks
# Symlinks are managed with Stow: https://www.gnu.org/software/stow/stow.html
# -----------------------------------------------------------------------------

TO_LINK := bash \
					 bat \
					 clifm \
					 environment \
					 fd \
					 fzf \
					 git \
					 kitty \
					 lazygit \
					 nvim \
					 ranger \
					 ripgrep \
					 tmux \
					 zsh \
					 $(SPECIFIC_TO_LINK)
LINK_TARGETS := $(addprefix link-,$(TO_LINK))
UNLINK_TARGETS := $(addprefix unlink-,$(TO_LINK))

# The `::` allow to re-declare the target to act as post-processing target.
$(LINK_TARGETS)::
	@echo -n "$(PURPLE)• Link $(subst link-,,$(@)) environment…$(RESET)"
	@stow $(_DRY_RUN) --restow $(subst link-,,$(@)) && echo " $(SUCCESS)" || echo " $(FAILURE)"
.PHONY: $(LINK_TARGETS)

## Generates all the symlinks.
setup-links: link-bin link-home $(LINK_TARGETS)
.PHONY: setup-links

## Generates only symlinks for the $HOME directory.
link-home:
	@echo -n "$(PURPLE)• Link home environment…$(RESET)"
	@stow --restow --dotfiles dot && echo " $(SUCCESS)" || echo " $(FAILURE)"
.PHONY: link-home

## Link personnal binaries.
link-bin:
	@echo -n "$(PURPLE)• Link binaries…$(RESET)"
	@mkdir -p $(XDG_DATA_HOME)/bin
	@stow --restow --target=$(XDG_DATA_HOME)/bin bin && echo " $(SUCCESS)" || echo " $(FAILURE)"
.PHONY: link-bin

link-ranger::
	@pip install --upgrade Pillow
.PHONY: link-ranger

## Deletes all the symlinks.
unlink-all: unlink-home unlink-bin $(UNLINK_TARGETS)
.PHONY: unlink-all

## Delete other symlinks.
$(UNLINK_TARGETS)::
	@echo -n "$(PURPLE)• Unlink $(subst unlink-,,$(@)) environment…$(RESET)"
	@stow --delete $(subst unlink-,,$(@)) && echo " $(SUCCESS)" || echo " $(FAILURE)"
.PHONY: $(UNLINK_TARGETS)

## Deletes symlinks in the Home directory.
unlink-home:
	@stow --dotfiles --delete dot
.PHONY: unlink-home

## Delete symlink of custom binaries.
unlink-bin:
	@stow --target=$(XDG_DATA_HOME)/bin --delete bin
.PHONY: unlink-bin
