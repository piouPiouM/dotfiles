#!/bin/sh
# Switch niri to "us" (layout 0 in config.kdl) while the NuPhy Air75 V3 is
# connected, back to "fr" (layout 1) once it is gone. Spawned by niri at startup.
#
# Detection, matched against /proc/bus/input/devices:
#   Bluetooth: device address, shown as "U: Uniq=<mac>"
#   USB wire/2.4G dongle: NuPhy vendor id 19f5, as in /etc/udev/rules.d/99-nuphy.rules
# ponytail: vendor match = any NuPhy USB keyboard; add "Product=<pid>" if you get a second one.
AIR75='^U: Uniq=f4:00:50:01:d6:19$|^I: Bus=0003 Vendor=19f5 '

state=
check() {
  if grep -qiE "$AIR75" /proc/bus/input/devices; then now=0; else now=1; fi
  # Only act on a change, so manual Mod+Shift+Space switches are not undone.
  [ "$now" = "$state" ] && return
  state=$now
  niri msg action switch-layout "$now"
}

check
udevadm monitor --udev --subsystem-match=input | while read -r _ _ action _; do
  case $action in add|remove) check ;; esac
done
