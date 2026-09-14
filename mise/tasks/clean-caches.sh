#!/usr/bin/env bash
# mise description="Clear uv/npm/pnpm/pip/bun/yarn caches in parallel"

set -uo pipefail

declare -A _cmds=(
  [uv]="uv cache clean"
  [npm]="npm cache clean --force"
  [pnpm]="pnpm store prune"
  [pip]="pip cache purge"
  [bun]="rm -rf $HOME/.bun/install/cache"
  [yarn]="yarn cache clean"
  [podman]="podman image prune -a -f"
)

declare _tmp
_tmp=$(mktemp -d)
trap 'rm -rf "$_tmp"' EXIT

declare -a _pids=() _names=()

for _tool in "${!_cmds[@]}"; do
  if command -v "$_tool" > /dev/null; then
    ${_cmds[$_tool]} > "${_tmp}/${_tool}" 2>&1 &
    _pids+=("$!")
    _names+=("$_tool")
  else
    echo "• Skipping $_tool (not installed)"
  fi
done

declare _status=0
for _i in "${!_pids[@]}"; do
  _name=${_names[_i]}
  if wait "${_pids[$_i]}"; then
    echo "✓ ${_name} cache cleared"
  else
    echo "✗ ${_name} cache clean failed" >&2
    sed 's/^/  /' "${_tmp}/${_name}" >&2
    if [[ $_name == podman ]] && grep -q "is in use by a container" "${_tmp}/${_name}"; then
      cat >&2 << 'EOF'
  → some images are held by stopped/external containers. Next:
      podman ps -a --external          # list them, including buildah/other-tool containers
      podman rm -f <container-id>      # remove ones you don't need, or:
      podman image prune -a -f --external
EOF
    fi
    _status=1
  fi
done

exit "$_status"
