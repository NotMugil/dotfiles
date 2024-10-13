#!/bin/bash

theme=$1
HYPR_DIR="$HOME/.config/hypr"
THEME_DIR="$HYPR_DIR/rices/$1"
LOCK_STYLES_DIR="$HOME/.config/hypr/hyprlock/styles"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock/hyprlock.conf"


# Change Hyprlock Background
ln -sf $THEME_DIR/hyprlock.png $HYPR_DIR/hyprlock/background

# Change Hyprland styles
ln -sf $THEME_DIR/colors.conf $HYPR_DIR/configs/colors.conf
ln -sf $THEME_DIR/theme.conf $HYPR_DIR/configs/theme.conf

case "$theme" in
    "Catppuccin")
        ln -sf $LOCK_STYLES_DIR/Catppuccin.conf $HYPRLOCK_CONF
        ;;
    "Tokyo-Night")
        ln -sf $LOCK_STYLES_DIR/Tokyo-Night.conf $HYPRLOCK_CONF
        ;;
    "Gruvbox-Dark")
        ln -sf $LOCK_STYLES_DIR/Gruvbox-Dark.conf $HYPRLOCK_CONF
        ;;
    "Starlit")
        ln -sf $LOCK_STYLES_DIR/Starlit.conf $HYPRLOCK_CONF
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for Hyprlock: $theme"
        ;;
esac
