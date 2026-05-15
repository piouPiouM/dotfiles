#!/usr/bin/env bash
# Wrap catppuccin lazygit themes with the gui: top-level key.
# Externals download from catppuccin/lazygit themes/<flavor>/mauve.yml which uses theme:
# as top-level; lazygit expects gui.theme.* so a gui: wrapper with indentation is required.
# Idempotent: skips files that are already wrapped.
set -euo pipefail

THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/lazygit/themes"

for flavor in frappe latte macchiato mocha; do
  f="$THEMES_DIR/catppuccin-$flavor.yml"
  [[ -f $f   ]] || continue
  head -1 "$f" | grep -q '^gui:' && continue # already wrapped
  {
    printf 'gui:\n'
    sed 's/^/  /' "$f"
  } > "$f.tmp" && mv "$f.tmp" "$f"
done