#!/usr/bin/env bash
# @file ppm::init
# @set PPM_ROOT string Directory of my custom scripts.

set -euo pipefail

# Short-circuit if init.sh has already been sourced.
[[ $(type -t ppm::init::loaded) == function ]] && return 0

PPM_ROOT="$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")"
export PPM_ROOT

source "${PPM_ROOT}/lib/failed.sh"
source "${PPM_ROOT}/lib/is_cmd.sh"
source "${PPM_ROOT}/lib/check_command.sh"

# @noargs
# @internal
ppm::init::loaded() {
	return 0
}
