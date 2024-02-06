#!/usr/bin/env bash
# @name ppm::failed
# @brief Exits the script with an error message.
# @package ppm
#
# @arg $1 number Exit code to raise.
# @arg $2 string Error message prefixed by an error mark.
#
# @stderr The computed error message.

set -euo pipefail

ppm::failed() {
	ppm::as_error "✗ $2"
	exit $1
}