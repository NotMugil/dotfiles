#!/bin/bash

# Define the directories
RICE_DIR="$HOME/.config/hypr/rices"
ROFI_DIR="$HOME/.config/rofi"
RICE_FILE="$HOME/.config/hypr/.rice"
WALLPAPERS_DIR="$HOME/.wallpapers"
HYPR_CONF="$HOME/.config/hypr/configs"


# Transition config
FPS=60
TYPE="any"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
SWWW_PARAMS="--transition-fps ${FPS} --transition-type ${TYPE} --transition-duration ${DURATION} --transition-bezier ${BEZIER}"

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
    WALLPAPERS_SRC="$RICE_DIR/$SELECTED_RICE/wallpapers"
    
    if [[ -f "$THEME_SCRIPT" ]]; then
        echo "Executing $THEME_SCRIPT..."
        bash "$THEME_SCRIPT"
        
        # Save the selected rice to .rice file
        echo "$SELECTED_RICE" > "$RICE_FILE"
        echo "Saved $SELECTED_RICE to $RICE_FILE."
        
        # Remove existing symlink if it exists
        if [[ -L "$WALLPAPERS_DIR" ]]; then
            echo "Removing existing symlink $WALLPAPERS_DIR."
            rm "$WALLPAPERS_DIR"
        elif [[ -d "$WALLPAPERS_DIR" ]]; then
            echo "Removing existing directory $WALLPAPERS_DIR."
            rm -r "$WALLPAPERS_DIR"
        fi

        # C1reate a new symlink to the selected rice's wallpapers
        echo "Creating symlink from $WALLPAPERS_SRC to $WALLPAPERS_DIR."
        ln -s "$WALLPAPERS_SRC" "$WALLPAPERS_DIR"
	ln -s "$RICE_DIR/$SELECTED_RICE/theme.conf" "$HYPR_CONF/theme.conf"	
	ln -s "$RICE_DIR/$SELECTED_RICE/colors.conf" "$HYPR_CONF/colors.conf"

        echo "Changing to default wallpaper of selected theme"
        swww img $WALLPAPERS_DIR/01.webp ${SWWW_PARAMS} && notify-send "Wallpaper Changed" -i "$WALLPAPERS_DIR/01.webp" --app-name=Wallpaper
        ln -sf "$WALLPAPERS_DIR/01.webp" "$HOME/.current_wallpaper"

    else
        echo "Theme script $THEME_SCRIPT does not exist."
    fi
else
    echo "No rice selected."
fi
