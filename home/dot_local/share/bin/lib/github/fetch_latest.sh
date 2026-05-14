#!/usr/bin/env bash

set -euo pipefail

source ppm::lib

ppm::github::latest_url() {
  ppm::check_command 'curl'

  local -r repo="$1"
  local -r archi="${2:-linux-x64}"

  command curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" | command grep -oE "https:.+${archi}\.tar\.gz"
}

ppm::github::fetch_latest() {
  local -r repo="$1"
  local -r destination_path="$2"
  local -r archi="${3:-linux-x64}"
  local -r url=$(ppm::github::latest_url "$repo" "$archi")

  command curl -fsSL --output-dir "$destination_path" --remote-name "$url" \
    || ppm::failed 1 "Downloading of ${url} has failed."

  echo "$destination_path/$(command basename "$url")"
}
