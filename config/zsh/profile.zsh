#!/usr/bin/env zsh

# execute Hyprland when in TTY1 only
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi
