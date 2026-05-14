#!/usr/bin/env bash
# @name pipeline
# @package ppm

set -euo pipefail

# @description Mute standard output.
ppm::mute() { "$@" > /dev/null >&1; }

# @description Mute standard and error outputs.
ppm::silence() { "$@" > /dev/null 2>&1; }

# @description Redirect output to the standard error.
ppm::as_error() { "$@" >&2; }
