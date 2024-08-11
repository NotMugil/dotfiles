#!/bin/bash

set -e

RICE_DIR="$HOME/.config/hypr/rices"
RICE_FILE="$HOME/.config/hypr/.rice"
ROFI_DIR="$HOME/.config/rofi"

command -v rofi &> /dev/null || { echo "rofi is not installed. Please install rofi to use this script." >&2; exit 1; }

[[ -d "$RICE_DIR" ]] || { echo "Directory $RICE_DIR does not exist." >&2; exit 1; }

RICES=$(for dir in "$RICE_DIR"/*/; do
    [[ -d "$dir" ]] && basename "$dir"
done)

[[ -n "$RICES" ]] || { echo "No rices found in $RICE_DIR." >&2; exit 1; }

SELECTED_RICE=$(echo "$RICES" | rofi -dmenu -p "Select Rice:" -theme "$ROFI_DIR/theme.rasi")

if [[ -n "$SELECTED_RICE" ]]; then
    THEME_SCRIPT="$RICE_DIR/$SELECTED_RICE/theme.sh"

    if [[ -f "$THEME_SCRIPT" ]]; then
        echo "Executing $THEME_SCRIPT..."
        bash "$THEME_SCRIPT" || { echo "Failed to execute $THEME_SCRIPT" >&2; exit 1; }


        echo "$SELECTED_RICE" > "$RICE_FILE" || { echo "Failed to save $SELECTED_RICE to $RICE_FILE" >&2; exit 1; }
        echo "Saved $SELECTED_RICE to $RICE_FILE."
    else
        echo "Theme script $THEME_SCRIPT does not exist." >&2
        exit 1
    fi
else
    echo "No rice selected." >&2
    exit 1
fi
