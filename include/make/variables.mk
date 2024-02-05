uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

ifeq ($(uname_S),Linux)
	CURRENT_OS := linux
	OS_LINUX := Yes
	OS_MACOS :=
endif

ifeq ($(uname_S),Darwin)
	CURRENT_OS := macos
	OS_LINUX :=
	OS_MACOS := Yes
endif

# https://stackoverflow.com/a/44221541/392725
_DRY_RUN := $(findstring -n,$(firstword -$(MAKEFLAGS)))

CURL_FLAGS := --silent --fail --location
NPM_FLAGS := --global --no-progress --no-fund --loglevel silent