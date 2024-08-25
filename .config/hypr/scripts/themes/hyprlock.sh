#!/bin/bash

theme=$1
HYPR_DIR="$HOME/.config/hypr"
THEME_DIR="$HYPR_DIR/rices/$1"


# Change Hyprlock Background
ln -sf $THEME_DIR/hyprlock.png $HYPR_DIR/hyprlock/background.png
