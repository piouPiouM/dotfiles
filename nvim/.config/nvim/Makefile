SHELL=/bin/bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL = watch
.DELETE_ON_ERROR:
.NOTPARALLEL:
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

test:
	@APP_ENV=test nvim --headless --noplugin \
		-u ./scripts/minimal_init.lua \
		-c "PlenaryBustedDirectory ./lua/tests/"
.PHONY: test

watch:
	@find . -name '*.lua' | entr -cd make --silent test
.PHONY: watch

TARGET_ARGS =
FIRST_TARGET := $(firstword $(MAKECMDGOALS))

ifeq (test-one,$(FIRST_TARGET))
	TARGET_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	_tmp := $(firstword $(TARGET_ARGS))
	SPEC_FILE := $(and $(wildcard $(_tmp)),$(_tmp))
endif

ifeq (watch-one,$(FIRST_TARGET))
	TARGET_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	_tmp := $(firstword $(TARGET_ARGS))
	SPEC_FILE := $(and $(wildcard $(_tmp)),$(_tmp))
endif

test-one:
	@APP_ENV=test nvim --headless --noplugin \
		-u ./scripts/minimal_init.lua \
		-c "PlenaryBustedFile $(SPEC_FILE)"
.PHONY: test-one

watch-one:
	@find . -name '*.lua' | entr -cd make --silent test-one $(SPEC_FILE)
.PHONY: watch-one

# Inhibits fake targets
$(TARGET_ARGS):
	@true
.PHONY: $(TARGET_ARGS)