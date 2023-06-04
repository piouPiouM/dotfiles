# -----------------------------------------------------------------------------
# Target: install fzf
# -----------------------------------------------------------------------------

## Install fzf (Fuzzy finder) from sources.
install-fzf:
	@echo "$(PURPLE)• Installing fzf from sources$(RESET)"
ifeq ($(wildcard $(XDG_DATA_HOME)/fzf-repo/.git/.),)
	@git clone --quiet --depth 1 https://github.com/junegunn/fzf.git $(XDG_DATA_HOME)/fzf-repo
else
	@cd $(XDG_DATA_HOME)/fzf-repo && git pull --quiet
endif
	@$(XDG_DATA_HOME)/fzf-repo/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
	@ln -rs $(XDG_DATA_HOME)/fzf-repo/fzf $(XDG_DATA_HOME)/bin/fzf
	@ln -rs $(XDG_DATA_HOME)/fzf-repo/fzf-tmux $(XDG_DATA_HOME)/bin/fzf-tmux
.PHONY: install-fzf

## Uninstall fzf (Fuzzy finder).
uninstall-fzf:
	@echo "$(PURPLE)• Uninstalling fzf$(RESET)"
	@$(XDG_CACHE_HOME)/fzf-repo/uninstall --xdg
	@rm -f $(XDG_DATA_HOME)/bin/fzf
	@rm -f $(XDG_DATA_HOME)/bin/fzf-tmux
	@rm -rf $(XDG_DATA_HOME)/fzf-repo
.PHONY: uninstall-fzf
