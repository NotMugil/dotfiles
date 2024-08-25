#!/bin/bash

theme=$1
HYPR_DIR="$HOME/.config/hypr"
THEME_FILE="$HOME/.config/palletes/rofi/current_theme.rasi"
THEME_STYLES_DIR="$HOME/.config/palletes/rofi/colors"

case "$theme" in
    "Catppuccin")
        ln -sf $THEME_STYLES_DIR/catppuccin.rasi $THEME_FILE
        ;;
    "Tokyo-Night")
        ln -sf $THEME_STYLES_DIR/tokyo-night.rasi $THEME_FILE
        ;;
    "Gruvbox-Dark")
        ln -sf $THEME_STYLES_DIR/gruvbox-dark.rasi $THEME_FILE
        ;;
    "Starlit")
        ln -sf $THEME_STYLES_DIR/starlit.rasi $THEME_FILE
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for Hyprlock: $theme"
        ;;
esac

