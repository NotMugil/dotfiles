#!/bin/bash

WALLPAPER_PATH="$HOME/.wallpapers"

# Function to list wallpaper filenames
list_wallpapers() {
    find "$WALLPAPER_PATH" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) -printf "%f\n"
}

# Function to set wallpaper
set_wallpaper() {
    local wallpaper="$1"
    swww img "$WALLPAPER_PATH/$wallpaper" \
        --transition-fps 60 \
        --transition-type top \
        --transition-duration 2 \
        --transition-bezier 0.25,1,0.5,1

    notify-send "Wallpaper Changed" "Switched to $wallpaper"
}

# If an argument is provided, set the wallpaper
if [ $# -eq 1 ]; then
    set_wallpaper "$1"
else
    # List all wallpaper filenames
    list_wallpapers
fi
