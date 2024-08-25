#!/bin/bash

THEME_DIR="$HOME/.config/hypr/rices"
WALLPAPER_DIR="$HOME/.wallpapers"
SCRIPT_DIR="$HOME/.config/hypr/scripts/themes"
CURRENT_THEME_FILE="$HOME/.config/hypr/.rice"
ROFI_THEME="$HOME/.config/rofi/theme.rasi"

# List available themes
list_themes() {
    ls "$THEME_DIR"
}

# Store current theme name
store_current_theme() {
    echo "$1" > "$CURRENT_THEME_FILE"
}

# Get current theme
get_current_theme() {
    if [ -f "$CURRENT_THEME_FILE" ]; then
        cat "$CURRENT_THEME_FILE"
    else
        echo "default"
    fi
}

# Send notification
notify() {
    notify-send "Theme Changed" "Current theme: $1"
}

# Function to switch theme
switch_theme() {
    theme=$1
    
    # Run individual application theme scripts
    "$SCRIPT_DIR/waybar.sh" "$theme"
    "$SCRIPT_DIR/kitty.sh" "$theme"
    "$SCRIPT_DIR/rofi.sh" "$theme"
    "$SCRIPT_DIR/swaync.sh" "$theme"
    "$SCRIPT_DIR/hyprlock.sh" "$theme"

    
    # Change wallpapers
    change_wallpapers "$theme"
    
    # Store current theme
    store_current_theme "$theme"
    
    # Send notification
    notify "$theme"
    
    # Additional theme-specific actions can be added here
}

# Change wallpapers
change_wallpapers() {
    theme=$1
    theme_wallpaper_dir="$THEME_DIR/$theme/wallpapers"

    # Create wallpaper dir, if it doesn't exist
    mkdir $WALLPAPER_DIR
    
    # Remove existing wallpapers 
    rm -rf $WALLPAPER_DIR/*

    # Symlink new wallpapers
    cp -r "$theme_wallpaper_dir"/* "$WALLPAPER_DIR/"
    
    # Optionally, set a wallpaper using swww or swaybg
    # swww img "$WALLPAPER_DIR/your_default_wallpaper.jpg"
}

# Main script
current_theme=$(get_current_theme)
selected_theme=$(list_themes | rofi -dmenu -p "Select a theme (current: $current_theme):" -theme "$ROFI_THEME")

if [ -n "$selected_theme" ]; then
    if [ "$selected_theme" != "$current_theme" ]; then
        switch_theme "$selected_theme"
        echo "Theme switched to $selected_theme"
    else
        echo "Selected theme is already active"
        notify-send "Theme Switch" "Selected theme ($selected_theme) is already active"
    fi
else
    echo "No theme selected"
fi
