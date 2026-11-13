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

# Put the named workspaces at index 1, 2, ... of their monitor, in this order.
order() {
  i=1
  for ws in "$@"; do
    niri msg action move-workspace-to-index --reference "$ws" "$i"
    i=$((i + 1))
  done
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

  # niri drops actions without an error before it is ready for a just-plugged
  # monitor, and for as long as the session is locked (dock plugged in while
  # suspended: the moves run before you unlock). Unlocking sends no workspace
  # event, so keep retrying until all three are there, unless the monitors
  # change meanwhile: the event that follows reruns this for the new set.
  # ponytail: polls 1/s while locked; a niri lock event would remove the poll.
  tries=0
  while :; do
    tries=$((tries + 1))
    for ws in Browse Code Docs; do
      niri msg action move-workspace-to-monitor --reference "$ws" "$ext"
    done
    [ "$(ws_on "$ext" | grep -c -e '"Browse"' -e '"Code"' -e '"Docs"')" = 3 ] && break
    [ "$tries" = 1 ] && logger -t ws-layout "ext=$ext waiting: locked or not ready"
    sleep 1
    if [ "$(niri msg outputs | grep '^Output ' | sort)" != "$outputs" ]; then
      logger -t ws-layout "ext=$ext gone after $tries tries: monitors changed"
      return
    fi
  done
  state=$outputs

  order Browse Code Docs
  order Social Media
  niri msg action focus-monitor "$ext"
  # A just-plugged monitor keeps the empty workspace niri made for it active.
  ws_on "$ext" | grep -q -E '^ \* [0-9]+$' && niri msg action focus-workspace Browse
  logger -t ws-layout "ext=$ext tries=$tries outputs: $(printf '%s' "$outputs" | tr '\n' ' ')"
}

# The event stream starts with the current state, so this also runs at login.
# Reconnect if the stream ends (niri can drop a client that stops reading, as
# this one does while place() retries); stop once niri itself is gone.
while niri msg version >/dev/null 2>&1; do niri msg event-stream; sleep 1; done |
  while read -r line; do
    case $line in "Workspaces changed"*) place ;; esac
  done
