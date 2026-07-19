#!/usr/bin/env bash
# mise description="Install Proton Pass on Fedora from the official release"

set -euo pipefail

trap cleanup EXIT

declare _tmp

cleanup() {
  [[ -d ${_tmp:-} ]] && rm -rf "$_tmp"
}

declare -a _missing=()
for cmd in curl jq sha512sum rpm; do
  command -v "$cmd" > /dev/null || _missing+=("$cmd")
done
if ((${#_missing[@]} > 0)); then
  echo "✗ Missing commands: ${_missing[*]}" >&2
  exit 127
fi

_tmp=$(mktemp -d)

_release_meta=$(curl -fsSL "https://proton.me/download/PassDesktop/linux/x64/version.json" | jq '.Releases[0]')
_release_version=$(jq --raw-output '.Version' <<< "$_release_meta")
_release_rpm=$(jq --raw-output '.File[]|select(.Identifier | startswith(".rpm")).Url' <<< "$_release_meta")
_release_checksum=$(jq --raw-output '.File[]|select(.Identifier | startswith(".rpm")).Sha512CheckSum' <<< "$_release_meta")

echo "• Installing Proton Pass version ${_release_version}"

curl -fsSL --output "${_tmp}/ProtonPass.rpm" "$_release_rpm"

echo "${_release_checksum} ${_tmp}/ProtonPass.rpm" | sha512sum --status --check - 2> /dev/null \
                                                                                              || {
    echo "✗ Incorrect checksum." >&2
    exit 1
  }

sudo rpm --install --force "${_tmp}/ProtonPass.rpm"
