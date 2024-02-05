RED   := $(shell tput -Txterm setaf 1)
GREEN := $(shell tput -Txterm setaf 2)
# Need interaction
YELLOW := $(shell tput -Txterm setaf 3)
# Information
PURPLE := $(shell tput -Txterm setaf 5)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

SUCCESS := $(GREEN) $(RESET)
FAILURE := $(RED)✗ $(RESET)

# Used to isolate shell commands from a foreach.
# https://www.extrema.is/blog/2021/12/17/makefile-foreach-commands
define newline


endef

define cmd_exists
	type -a $(1) > /dev/null 2>&1
endef

define register_manpath
	$(GNU_GREP) -qs $(1) $$HOME/.manpath || echo "MANDATORY_MANPATH $(1)" >> $$HOME/.manpath
endef

define failure
	echo "  $(FAILURE) $(1)$(RESET)"
endef

define success
	echo "  $(SUCCESS) $(1)$(RESET)"
endef
