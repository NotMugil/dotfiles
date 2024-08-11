#!/bin/bash

# Define the directories
RICE_DIR="$HOME/.config/hypr/rices"
RICE_FILE="$HOME/.config/hypr/.rice"
ROFI_DIR="$HOME/.config/rofi"

# Check if rofi is installed
if ! command -v rofi &> /dev/null; then
    echo "rofi is not installed. Please install rofi to use this script."
    exit 1
fi

# Check if the rices directory exists
if [[ ! -d "$RICE_DIR" ]]; then
    echo "Directory $RICE_DIR does not exist."
    exit 1
fi

# List all directories (rices) inside the RICE_DIR
RICES=$(for dir in "$RICE_DIR"/*/; do
    if [[ -d "$dir" ]]; then
        basename "$dir"
    fi
done)

# Check if there are any rices to select
if [[ -z "$RICES" ]]; then
    echo "No rices found in $RICE_DIR."
    exit 1
fi

# Use rofi to display the list and allow selection
SELECTED_RICE=$(echo "$RICES" | rofi -dmenu -p "Select Rice:" -theme "$ROFI_DIR/theme.rasi")

# Check if the user selected a rice
if [[ -n "$SELECTED_RICE" ]]; then
    THEME_SCRIPT="$RICE_DIR/$SELECTED_RICE/theme.sh"

    if [[ -f "$THEME_SCRIPT" ]]; then
        echo "Executing $THEME_SCRIPT..."
        bash "$THEME_SCRIPT"

        # Save the selected rice to .rice file
        echo "$SELECTED_RICE" > "$RICE_FILE"
        echo "Saved $SELECTED_RICE to $RICE_FILE."
    else
        echo "Theme script $THEME_SCRIPT does not exist."
    fi
else
    echo "No rice selected."
fi
