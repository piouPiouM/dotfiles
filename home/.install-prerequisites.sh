#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOUD_COMMANDS=('apply' 'doctor' 'init' 'status' 'update')
_LOUD=0
for _cmd in "${LOUD_COMMANDS[@]}"; do [[ $_cmd == "${CHEZMOI_COMMAND:-}" ]] && {
  _LOUD=1
  break
}; done
unset _cmd
((CHEZMOI)) || _LOUD=1

NEED_PREREQUISITIES_COMMANDS=('apply' 'doctor' 'init' 'status' 'update')
_NEED_PREREQUISITIES=0
for _cmd in "${NEED_PREREQUISITIES_COMMANDS[@]}"; do [[ $_cmd == "${CHEZMOI_COMMAND:-}" ]] && {
  _NEED_PREREQUISITIES=1
  break
}; done
unset _cmd
((CHEZMOI)) || _NEED_PREREQUISITIES=1

# ─── Logging ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

loud() { ((_LOUD)); }
check_prerequisites() { ((_NEED_PREREQUISITIES)); }

step() {
  loud || return 0
  echo -e "${BLUE}▶${RESET} ${BOLD}[${1}]${RESET} ${*:2}"
}
ok() {
  loud || return 0
  echo -e "${GREEN}✓${RESET} ${BOLD}[${1}]${RESET} ${*:2}"
}
skip() {
  loud || return 0
  echo -e "${YELLOW}⊘${RESET} ${BOLD}[${1}]${RESET} ${*:2}"
}
err() {
  loud || return 0
  echo -e "${RED}✗${RESET} ${BOLD}[${1}]${RESET} ${*:2}" >&2
}
warn() {
  loud || return 0
  echo -e "${YELLOW}⚠${RESET} ${BOLD}[${1}]${RESET} ${*:2}"
}

# ─── Age key / recipient check ────────────────────────────────────────────────
AGE_KEY="${HOME}/.private/age/chezmoi.key.txt"
AGE_RECIPIENT="${HOME}/.private/age/chezmoi.recipient.txt"

if [[ ! -f $AGE_KEY || ! -f $AGE_RECIPIENT ]]; then
  warn "age-keys" "Age key/recipient files not found — copy them to:"
  [[ ! -f $AGE_KEY ]] && warn "age-keys" "  • ${AGE_KEY}"
  [[ ! -f $AGE_RECIPIENT ]] && warn "age-keys" "  • ${AGE_RECIPIENT}"
fi

# ─── All prerequisites already installed ─────────────────────────────────────

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

  [[ -n $version && -n $bin_url && -n $bin_hash ]] || {
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

  [[ -n $expected_hash ]] || {
    err "$TAG" "Could not find checksum for ${archive} in SHASUMS256.txt"

    return 1
  }

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
  if command -v pass-cli &> /dev/null; then
    bin="pass-cli"
  elif [[ -x "${HOME}/.local/bin/pass-cli" ]]; then
    bin="${HOME}/.local/bin/pass-cli"
  else
    err "$TAG" "Binary not found, cannot authenticate"

    return 1
  fi

  step "$TAG" "Testing authenticated connection..."
  if "$bin" test &> /dev/null; then
    ok "$TAG" "Already authenticated"

    return 0
  fi

  step "$TAG" "Not authenticated — launching browser login..."
  "$bin" login
  ok "$TAG" "Authentication complete"
}

# ─── Setup secrets ────────────────────────────────────────────────────────────
setup_secrets() {
  local TAG="secrets"
  local secrets_file="${SCRIPT_DIR}/.chezmoidata/secrets.yaml"
  local private_secrets="${HOME}/.private/chezmoi/secrets.yaml"
  local encrypted="${SCRIPT_DIR}/private_dot_private/private_chezmoi/encrypted_private_secrets.yaml.age"

  encrypt_secrets() {
    [[ -f $private_secrets ]] || return 0

    if [[ -f $encrypted && ! $private_secrets -nt $encrypted ]]; then
      skip "$TAG" "$(basename "$encrypted") is up to date"

      return 0
    fi

    [[ -f $AGE_RECIPIENT ]] || {
      warn "$TAG" "Age recipient not found — skipping encryption of $(basename "$private_secrets")"

      return 1
    }

    step "$TAG" "Encrypting $(basename "$private_secrets") → $(basename "$encrypted")..."
    mkdir -p "$(dirname "$encrypted")"
    age --encrypt -r "$(cat "$AGE_RECIPIENT")" -o "$encrypted" "$private_secrets"
    ok "$TAG" "Encrypted to $(basename "$encrypted")"
  }

  # Case 1: fresh clone — neither plain-text copy exists, decrypt from encrypted
  if [[ ! -f $private_secrets && ! -f $secrets_file ]]; then
    [[ -f $encrypted ]] || {
      err "$TAG" "No secrets source found"

      return 1
    }

    [[ -f $AGE_KEY ]] || {
      err "$TAG" "Age key not found — cannot decrypt $(basename "$encrypted")"

      return 1
    }

    step "$TAG" "Decrypting $(basename "$encrypted") → $(basename "$private_secrets")..."
    mkdir -p "$(dirname "$private_secrets")"
    age --decrypt -i "$AGE_KEY" -o "$private_secrets" "$encrypted"
    ok "$TAG" "Decrypted to $(basename "$private_secrets")"

    step "$TAG" "Copying $(basename "$private_secrets") → $(basename "$secrets_file")..."
    mkdir -p "$(dirname "$secrets_file")"
    cp "$private_secrets" "$secrets_file"
    ok "$TAG" "Copied to $(basename "$secrets_file")"

    return 0
  fi

  # Ensure both plain-text copies exist before comparing
  if [[ ! -f $private_secrets ]]; then
    step "$TAG" "Copying $(basename "$secrets_file") → $(basename "$private_secrets")..."
    mkdir -p "$(dirname "$private_secrets")"
    cp "$secrets_file" "$private_secrets"
    ok "$TAG" "Copied to $(basename "$private_secrets")"
    encrypt_secrets

    return
  fi

  if [[ ! -f $secrets_file ]]; then
    step "$TAG" "Copying $(basename "$private_secrets") → $(basename "$secrets_file")..."
    mkdir -p "$(dirname "$secrets_file")"
    cp "$private_secrets" "$secrets_file"
    ok "$TAG" "Copied to $(basename "$secrets_file")"
    encrypt_secrets

    return
  fi

  # Both plain-text copies exist — check content first
  local h1 h2
  h1=$(md5sum "$secrets_file" | awk '{print $1}')
  h2=$(md5sum "$private_secrets" | awk '{print $1}')

  if [[ $h1 == "$h2" ]]; then
    skip "$TAG" "$(basename "$secrets_file") already in sync"
    encrypt_secrets

    return 0
  fi

  # Case 2: secrets_file was edited — sync to private_secrets
  if [[ $secrets_file -nt $private_secrets ]]; then
    step "$TAG" "$(basename "$secrets_file") is newer — syncing to $(basename "$private_secrets")..."
    cp "$secrets_file" "$private_secrets"
    ok "$TAG" "Synced $(basename "$private_secrets")"

  # Case 3: private_secrets was edited (or same timestamp) — sync to secrets_file
  else
    step "$TAG" "$(basename "$private_secrets") is newer — syncing to $(basename "$secrets_file")..."
    cp "$private_secrets" "$secrets_file"
    ok "$TAG" "Synced $(basename "$secrets_file")"
  fi

  encrypt_secrets
}

# ─── Main ─────────────────────────────────────────────────────────────────────
if ! check_prerequisites; then
  loud && echo -e "\n${BOLD}Prerequisites not required for this command, skipping${RESET}\n"
  exit 0
fi

FAILED=0

loud && echo -e "\n${BOLD}Checking prerequisites...${RESET}\n"
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

wait "$MISE_PID" || {
  err "mise" "Installation failed (see above)"
  FAILED=1
}

wait "$PASS_PID" || {
  err "pass-cli" "Installation failed (see above)"
  FAILED=1
}
if [[ $FAILED -eq 0 ]]; then
  loud && echo ""
  authenticate_pass_cli || {
    err "pass-cli" "Authentication failed"
    FAILED=1
  }
fi

if [[ $FAILED -eq 0 ]]; then
  loud && echo ""
  setup_secrets || {
    err "secrets" "Setup failed"
    FAILED=1
  }
fi

loud && echo ""
if [[ $FAILED -eq 0 ]]; then
  loud && echo -e "${GREEN}${BOLD}✓ All prerequisites installed.${RESET}"
else
  loud && echo -e "${RED}${BOLD}✗ One or more installations failed.${RESET}"
  exit 1
fi

exit 0
