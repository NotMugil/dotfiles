#!/bin/bash

# Define directories
styles_dir="$HOME/.config/waybar/bars"
waybar_config_dir="$HOME/.config/waybar"
config_file="config.jsonc"
style_file="style.css"
waybar_refresh_script="$HOME/.scripts/waybar.sh"

# Function to display menu options
menu() {
    options=()
    while IFS= read -r version; do
        options+=("$version")
    done < <(find "$styles_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Function to refresh Waybar
refresh_waybar() {
     if pgrep -x "waybar"; then
        pkill -x waybar
        waybar &
    else
        waybar &
    fi
}

# Main function
main() {
    selected_version=$(menu | rofi -dmenu -config ~/.config/rofi/waybar.rasi -p "Select a version:")

    if [[ -z "$selected_version" ]]; then
        echo "No version selected. Exiting."
        exit 1
    fi

    # Check if selected version exists
    if [[ ! -d "$styles_dir/$selected_version" ]]; then
        echo "Selected version doesn't exist. Exiting."
        exit 1
    fi

    # Create symlinks for config and style files
    ln -sf "$styles_dir/$selected_version/$config_file" "$waybar_config_dir/$config_file"
    ln -sf "$styles_dir/$selected_version/$style_file" "$waybar_config_dir/$style_file"

    echo "Configurations updated to $selected_version."

    # Check if symlinks are created successfully
    if [[ $? -eq 0 ]]; then
        echo "Configurations updated to $selected_version."
    else
        echo "Failed to update configurations."
        exit 1
    fi
    
    # Refresh Waybar
    refresh_waybar
}

main
