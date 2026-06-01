#!/usr/bin/env bash
set -euo pipefail

# All prerequisites already installed
if command -v age &> /dev/null && command -v pass-cli &> /dev/null && command -v mise &> /dev/null; then
  exit 0
fi

# ─── Logging ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

step() { echo -e "${BLUE}▶${RESET} ${BOLD}[${1}]${RESET} ${*:2}"; }
ok() { echo -e "${GREEN}✓${RESET} ${BOLD}[${1}]${RESET} ${*:2}"; }
skip() { echo -e "${YELLOW}⊘${RESET} ${BOLD}[${1}]${RESET} ${*:2}"; }
err() { echo -e "${RED}✗${RESET} ${BOLD}[${1}]${RESET} ${*:2}" >&2; }

# ─── Helpers ──────────────────────────────────────────────────────────────────
_fetch() {
  local url="$1" out="${2:--}"
  if command -v curl &> /dev/null; then
    curl -fsSL -o "$out" "$url"
  elif command -v wget &> /dev/null; then
    wget -qO "$out" "$url"
  else
    echo "error: neither curl nor wget is available" >&2
    return 1
  fi
}

# Minimal JSON string-value extractor (no jq required)
_json_str() {
  grep -o "\"${1}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" \
                                                        | head -1 | sed 's/.*":[[:space:]]*"\(.*\)"/\1/' || true
}

# ─── Install age ──────────────────────────────────────────────────────────────
install_age() {
  local TAG="age"

  if command -v age &> /dev/null; then
    skip "$TAG" "already installed — $(age --version 2>&1 | head -1)"
    return 0
  fi

  step "$TAG" "Fetching latest release info..."
  local meta version
  meta=$(_fetch "https://api.github.com/repos/FiloSottile/age/releases/latest" -)
  version=$(echo "$meta" | _json_str "tag_name")
  [[ -n $version ]] || {
    err "$TAG" "Could not resolve latest version"
    return 1
  }

  local url="https://github.com/FiloSottile/age/releases/download/${version}/age-${version}-linux-amd64.tar.gz"
  local tmpdir
  tmpdir=$(mktemp -d)
  # shellcheck disable=SC2064
  trap "rm -rf '$tmpdir'" RETURN

  step "$TAG" "Downloading ${version}..."
  _fetch "$url" "$tmpdir/age.tar.gz"

  step "$TAG" "Extracting archive..."
  tar -xzf "$tmpdir/age.tar.gz" -C "$tmpdir"

  step "$TAG" "Installing binaries to ~/.local/bin..."
  mkdir -p "${HOME}/.local/bin"
  install -m755 "$tmpdir/age/age" "${HOME}/.local/bin/age"
  install -m755 "$tmpdir/age/age-keygen" "${HOME}/.local/bin/age-keygen"

  ok "$TAG" "Installed ${version}"
}

# ─── Install Proton Pass CLI ──────────────────────────────────────────────────
install_pass_cli() {
  local TAG="pass-cli"

  if command -v pass-cli &> /dev/null; then
    skip "$TAG" "already installed — $(pass-cli --version 2>&1 | head -1)"
    return 0
  fi

  step "$TAG" "Fetching version manifest..."
  local meta version bin_url bin_hash
  meta=$(_fetch "https://proton.me/download/pass-cli/versions.json" -)
  version=$(echo "$meta" | grep '"version"' | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
  bin_url=$(echo "$meta" | grep '"url".*pass-cli-linux-x86_64' | sed 's/.*"url"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
  bin_hash=$(echo "$meta" | grep -A1 'pass-cli-linux-x86_64"' | grep '"hash"' | sed 's/.*"hash"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

  [[ -n $version && -n $bin_url && -n $bin_hash ]] \
                                                   || {
      err "$TAG" "Could not parse version manifest"
      return 1
    }

  local tmpdir
  tmpdir=$(mktemp -d)
  # shellcheck disable=SC2064
  trap "rm -rf '$tmpdir'" RETURN

  step "$TAG" "Downloading ${version}..."
  _fetch "$bin_url" "$tmpdir/pass-cli"

  step "$TAG" "Verifying checksum..."
  local actual_hash
  actual_hash=$(sha256sum "$tmpdir/pass-cli" | awk '{print $1}')
  if [[ $actual_hash != "$bin_hash" ]]; then
    err "$TAG" "Checksum mismatch! expected=${bin_hash} got=${actual_hash}"
    return 1
  fi

  step "$TAG" "Installing binary to ~/.local/bin..."
  mkdir -p "${HOME}/.local/bin"
  install -m755 "$tmpdir/pass-cli" "${HOME}/.local/bin/pass-cli"

  step "$TAG" "Installing zsh completion..."
  local zsh_dir="${HOME}/.local/share/zsh/site-functions"
  mkdir -p "$zsh_dir"
  "${HOME}/.local/bin/pass-cli" completions zsh > "$zsh_dir/_pass-cli"

  ok "$TAG" "Installed ${version} and configured zsh completion"
}

# ─── Install mise ─────────────────────────────────────────────────────────────
install_mise() {
  local TAG="mise"

  if command -v mise &> /dev/null; then
    skip "$TAG" "already installed — $(mise --version 2>&1 | head -1)"
    return 0
  fi

  step "$TAG" "Fetching latest release info..."
  local meta version
  meta=$(_fetch "https://api.github.com/repos/jdx/mise/releases/latest" -)
  version=$(echo "$meta" | _json_str "tag_name")
  [[ -n $version ]] || {
    err "$TAG" "Could not resolve latest version"
    return 1
  }

  local archive="mise-${version}-linux-x64.tar.gz"
  local url="https://github.com/jdx/mise/releases/download/${version}/${archive}"
  local tmpdir
  tmpdir=$(mktemp -d)
  # shellcheck disable=SC2064
  trap "rm -rf '$tmpdir'" RETURN

  local shasums_url="https://github.com/jdx/mise/releases/download/${version}/SHASUMS256.txt"

  step "$TAG" "Downloading ${version}..."
  _fetch "$url" "$tmpdir/${archive}"
  _fetch "$shasums_url" "$tmpdir/SHASUMS256.txt"

  step "$TAG" "Verifying checksum..."
  local expected_hash actual_hash
  expected_hash=$(grep "${archive}" "$tmpdir/SHASUMS256.txt" | awk '{print $1}')
  [[ -n $expected_hash ]] || { err "$TAG" "Could not find checksum for ${archive} in SHASUMS256.txt"; return 1; }
  actual_hash=$(sha256sum "$tmpdir/${archive}" | awk '{print $1}')
  if [[ $actual_hash != "$expected_hash" ]]; then
    err "$TAG" "Checksum mismatch! expected=${expected_hash} got=${actual_hash}"
    return 1
  fi

  step "$TAG" "Extracting archive..."
  tar -xzf "$tmpdir/${archive}" -C "$tmpdir"

  step "$TAG" "Installing binary to ~/.local/bin..."
  mkdir -p "${HOME}/.local/bin"
  install -m755 "$tmpdir/mise/bin/mise" "${HOME}/.local/bin/mise"

  ok "$TAG" "Installed ${version}"
}

# ─── Authenticate Proton Pass CLI ─────────────────────────────────────────────
authenticate_pass_cli() {
  local TAG="pass-cli"
  local bin

  # Resolve binary — may have just been installed to ~/.local/bin outside PATH
  if command -v pass-cli &>/dev/null; then
    bin="pass-cli"
  elif [[ -x "${HOME}/.local/bin/pass-cli" ]]; then
    bin="${HOME}/.local/bin/pass-cli"
  else
    err "$TAG" "Binary not found, cannot authenticate"
    return 1
  fi

  step "$TAG" "Testing authenticated connection..."
  if "$bin" test &>/dev/null; then
    ok "$TAG" "Already authenticated"
    return 0
  fi

  step "$TAG" "Not authenticated — launching browser login..."
  "$bin" login
  ok "$TAG" "Authentication complete"
}

# ─── Main ─────────────────────────────────────────────────────────────────────
echo -e "\n${BOLD}Installing prerequisites...${RESET}\n"

FAILED=0

install_age &
AGE_PID=$!

install_pass_cli &
PASS_PID=$!

install_mise &
MISE_PID=$!

wait "$AGE_PID" || {
  err "age" "Installation failed (see above)"
  FAILED=1
}
wait "$PASS_PID" || {
  err "pass-cli" "Installation failed (see above)"
  FAILED=1
}
wait "$MISE_PID" || {
  err "mise" "Installation failed (see above)"
  FAILED=1
}

if [[ $FAILED -eq 0 ]]; then
  echo ""
  authenticate_pass_cli || {
    err "pass-cli" "Authentication failed"
    FAILED=1
  }
fi

echo ""
if [[ $FAILED -eq 0 ]]; then
  echo -e "${GREEN}${BOLD}✓ All prerequisites installed.${RESET}"
else
  echo -e "${RED}${BOLD}✗ One or more installations failed.${RESET}"
  exit 1
fi
