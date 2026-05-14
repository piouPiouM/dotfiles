#!/usr/bin/env bash
# @name ppm::ensure_dir
# @brief Creates the given directory if it doesn't exist.
# @package ppm
#
# @arg $1 string Name of the directory to test.

set -euo pipefail

ppm::ensure_dir() {
  [[ -d $1  ]] || mkdir -p "$1"
}