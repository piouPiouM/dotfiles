#!/usr/bin/env bash
# @name ppm::is_cmd
# @brief Test for existence of a command.
# @package ppm
#
# @arg $1 string Name of the command to test.
#
# @exitcode 0 If command exists.
# @exitcode 1 If command does not exists.
set -euo pipefail

ppm::is_cmd() {
  local n=0
  if [[ $1 == "-n" ]]; then
    n=1
    shift
  fi

  command -v "$1" > /dev/null

  return $((n ^ $?))
}
