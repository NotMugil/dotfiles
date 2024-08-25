#!/bin/bash

theme=$1
HYPR_DIR="$HOME/.config/hypr"
STYLES_DIR="$HOME/.config/swaync/styles"
STYLE_FILE="$HOME/.config/swaync/style.css"
CONFIG_FILE="$HOME/.config/swaync/config.json"


case "$theme" in
    "Catppuccin")
        ln -sf $STYLES_DIR/Catppuccin/config.json $CONFIG_FILE        
	ln -sf $STYLES_DIR/Catppuccin/style.css $STYLE_FILE
        ;;
    "Tokyo-Night")
        ln -sf $STYLES_DIR/Tokyo-Night/config.json $CONFIG_FILE        
	ln -sf $STYLES_DIR/Tokyo-Night/style.css $STYLE_FILE
        ;;
    "Gruvbox-Dark")
        ln -sf $STYLES_DIR/Gruvbox-Dark/config.json $CONFIG_FILE        
	ln -sf $STYLES_DIR/Gruvbox-Dark/style.css $STYLE_FILE
        ;;
    "Starlit")
        ln -sf $STYLES_DIR/Starlit/config.json $CONFIG_FILE        
	ln -sf $STYLES_DIR/Starlit/style.css $STYLE_FILE
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for Hyprlock: $theme"
        ;;
esac

# Refresh Swaync config and style
swaync-client -R 
swaync-client -rs
