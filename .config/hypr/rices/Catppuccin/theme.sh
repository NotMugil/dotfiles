#!/bin/bash

# Define the directory containing your theme scripts
SCRIPT_DIR="$HOME/.config/hypr/scripts/themes"

# Define the directory containing your themes
THEME_DIR="$HOME/.config/hypr/rices"

# Define the directory containing rofi theme
ROFI_THEME="$HOME/.config/rofi/theme.rasi"

# List themes from the directory
themes=$(ls "$THEME_DIR")

# Use rofi to select a theme
selected_theme=$(echo "$themes" | rofi -dmenu -p "Select Theme:" -theme "$ROFI_THEME")

# Check if a theme was selected
if [ -z "$selected_theme" ]; then
    echo "No theme selected."
    exit 1
fi

# Define and execute commands to change themes using individual scripts
echo "Switching to theme: $selected_theme"

# Run the theme change scripts
"$SCRIPT_DIR/kitty.sh" "Catppuccin"
"$SCRIPT_DIR/rofi.sh" "Catppuccin"
"$SCRIPT_DIR/waybar.sh" "Catppuccin"
"$SCRIPT_DIR/nvim.sh" "Catppuccin"
"$SCRIPT_DIR/firefox.sh" "Catppuccin"

echo "Theme applied. Please restart your applications to see changes."
