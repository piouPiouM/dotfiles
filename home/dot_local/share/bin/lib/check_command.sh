#!/usr/bin/env bash
# @name ppm::check_command
# @brief Check for the existence of a command, otherwise exit with an error message.
# @package ppm
#
# @arg $1 string Name of the command to test.
#
# @exitcode 0 If command exists.
# @exitcode 127 If command does not exists.

set -euo pipefail

ppm::check_command() {
  ppm::is_cmd "${1}" || ppm::failed 127 "Command not found: ${1}"
}