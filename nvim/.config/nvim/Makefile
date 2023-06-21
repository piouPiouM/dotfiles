SHELL=/bin/bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL = watch
.DELETE_ON_ERROR:
.NOTPARALLEL:
.ONESHELL:
# .SHELLFLAGS := -eu -o pipefail -c

test:
	@nvim --headless --noplugin \
		-u $$XDG_DATA_HOME/nvim/site/pack/packer/start/plenary.nvim/tests/minimal_init.vim \
		-c "PlenaryBustedDirectory ./lua/tests/"
.PHONY: test

watch:
	@find . -name '*.lua' | entr -cd make --silent test
.PHONY: watch