#!/bin/sh
# Move the Browse, Code and Docs workspaces to the external monitor (BenQ at
# work, ASUS at home) whenever the set of connected outputs changes.
# Social and Media are pinned to the laptop in config.kdl. When the external
# monitor is unplugged, niri itself moves its workspaces back to the laptop.
# ponytail: "external" = first non-laptop output; pick by name if you ever run two.
LAPTOP=eDP-1

state=
place() {
  outputs=$(niri msg outputs | sed -n 's/^Output .*(\(.*\))$/\1/p' | sort | tr '\n' ' ')
  # Only act on a change, so a workspace moved by hand stays where you put it.
  [ "$outputs" = "$state" ] && return
  state=$outputs
  ext=$(printf '%s\n' $outputs | grep -v -x "$LAPTOP" | head -n 1)
  [ -n "$ext" ] || return
  for ws in Browse Code Docs; do
    niri msg action move-workspace-to-monitor --reference "$ws" "$ext"
  done
}

# The event stream starts with the current state, so this also runs at login.
niri msg event-stream | while read -r line; do
  case $line in "Workspaces changed"*) place ;; esac
done
