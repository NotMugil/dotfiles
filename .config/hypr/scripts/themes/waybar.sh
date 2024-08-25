#!/bin/bash

theme=$1
HYPR_DIR="$HOME/.config/hypr"
THEME_FILE="$HOME/.config/waybar/colors/current-theme.css"
THEME_STYLES_DIR="$HOME/.config/waybar/colors"

case "$theme" in
    "Catppuccin")
        ln -sf $THEME_STYLES_DIR/catppuccin.css $THEME_FILE
        ;;
    "Tokyo-Night")
        ln -sf $THEME_STYLES_DIR/tokyo-night.css $THEME_FILE
        ;;
    "Gruvbox-Dark")
        ln -sf $THEME_STYLES_DIR/gruvbox-dark.css $THEME_FILE
        ;;
    "Starlit")
        ln -sf $THEME_STYLES_DIR/starlit.css $THEME_FILE
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for Hyprlock: $theme"
        ;;
esac

$HYPR_DIR/scripts/toggle_waybar.sh
