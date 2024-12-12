#!/usr/bin/env bash
spaces() {
   active_workspace=$(hyprctl activeworkspace -j | jq -r .id)
   hyprctl workspaces -j | jq -c --arg active "$active_workspace" \
     '[.[] | select(.windows > 0 or (.id | tostring) == $active) | {id: (.id | tostring), windows: .windows}] |
     sort_by(.id | tonumber)'
}
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
   spaces
done
