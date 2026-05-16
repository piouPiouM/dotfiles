#!/usr/bin/env bash
# Rose Pine fzf themes: externals download them with FZF_DEFAULT_OPTS; rename to FZF_THEME
# (the fzf plugin reads $FZF_THEME and splices it into FZF_DEFAULT_OPTS at shell init).
#
set -euo pipefail

FZF_THEMES="${XDG_DATA_HOME:-$HOME/.local/share}/fzf/themes"

# --- Rose Pine ---
for variant in rose-pine rose-pine-dawn rose-pine-moon; do
  f="$FZF_THEMES/$variant.sh"
  [[ -f $f   ]] || continue
  grep -q 'FZF_DEFAULT_OPTS' "$f" || continue # already transformed
  sed -i 's/FZF_DEFAULT_OPTS/FZF_THEME/' "$f"
done

# --- GitHub (projekt0n/github-theme-contrib) ---
# GitHub fzf themes: not in externals (require rename + reformat); download once here.
# To force re-fetch, delete any github-*.sh file from the themes directory.
if [[ ! -f "$FZF_THEMES/github-dark.sh" ]]; then
  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT

  curl -fsSL -o "$TMP/archive.tar.gz" \
    "https://github.com/projekt0n/github-theme-contrib/archive/main.tar.gz"
  tar -xzf "$TMP/archive.tar.gz" -C "$TMP" --strip-components=1

  for src in "$TMP/themes/fzf/github_"*; do
    [[ -f $src   ]] || continue
    name=$(basename "$src")
    dest="$FZF_THEMES/${name//_/-}.sh"
    sed -E "s/.*'(.*)'/export FZF_THEME=\"\1\"/;s@ --@\n  --@g" "$src" > "$dest"
  done
fi