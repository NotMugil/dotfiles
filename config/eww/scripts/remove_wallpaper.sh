#!/bin/bash

WALLPAPER_PATH="$HOME/.wallpapers"

wallpaper="$1"
full_path="${WALLPAPER_PATH}/${wallpaper}"

# Remove the actual file
rm "$full_path"

# Notify
notify-send "Wallpaper Removed" "Deleted $wallpaper"
