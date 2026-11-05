#!/bin/sh
# Move the Browse, Code and Docs workspaces to the external monitor (BenQ at
# work, ASUS at home) whenever the set of connected monitors changes, then focus
# that monitor. Social and Media are pinned to the laptop in config.kdl. When the
# external monitor is unplugged, niri itself moves its workspaces back to the
# laptop. Each pass is logged: journalctl --user -t ws-layout
# ponytail: "external" = first non-laptop output; pick by name if you ever run two.
LAPTOP=eDP-1

# The workspace lines of one output in `niri msg workspaces`.
ws_on() {
  niri msg workspaces | awk -v o="Output \"$1\":" '/^Output/ { on = ($0 == o); next } on'
}

state=
place() {
  # Full "Output <name> (<connector>)" lines: home and work screens can show up
  # on the same connector, so connectors alone can miss a swap.
  outputs=$(niri msg outputs | grep '^Output ' | sort)
  # Only act on a change, so a workspace moved by hand stays where you put it.
  [ "$outputs" = "$state" ] && return
  ext=$(printf '%s\n' "$outputs" | sed -n 's/^Output .*(\(.*\))$/\1/p' | grep -v -x "$LAPTOP" | head -n 1)
  if [ -z "$ext" ]; then state=$outputs; return; fi

  # A move sent before niri is ready for a just-plugged monitor is dropped
  # without an error, so retry until all three are there (5 s at most).
  for _ in 1 2 3 4 5 6 7 8 9 10; do
    # Reverse order: each move lands right after the active workspace.
    for ws in Docs Code Browse; do
      niri msg action move-workspace-to-monitor --reference "$ws" "$ext"
    done
    landed=$(ws_on "$ext" | grep -c -e '"Browse"' -e '"Code"' -e '"Docs"')
    [ "$landed" = 3 ] && break
    sleep 0.5
  done
  logger -t ws-layout "ext=$ext landed=$landed/3 outputs: $(printf '%s' "$outputs" | tr '\n' ' ')"
  # Not committed on failure, so the next workspace event retries.
  [ "$landed" = 3 ] || return
  state=$outputs

  niri msg action focus-monitor "$ext"
  # A just-plugged monitor keeps the empty workspace niri made for it active.
  ws_on "$ext" | grep -q -E '^ \* [0-9]+$' && niri msg action focus-workspace Browse
}

# The event stream starts with the current state, so this also runs at login.
niri msg event-stream | while read -r line; do
  case $line in "Workspaces changed"*) place ;; esac
done
