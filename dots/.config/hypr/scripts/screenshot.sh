#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  -f, --full     Capture full screen"
    echo "  -s, --select   Capture selected area"
    echo "  -m, --monitor  Capture active monitor"
    echo "  -h, --help     Display this help message"
    exit 0
}

# Function to generate a unique filename and ensure the directory exists
generate_filename() {
    local dir="$HOME/Pictures/Screenshots"
    mkdir -p "$dir"
    echo "$dir/screenshot_$(date +%Y%m%d_%H%M%S).png"
}

# Function to send a notification with an image preview
send_notification() {
    local file_path="$1"
    notify-send "Screenshot taken" "$file_path" \
        --icon="$file_path" \
        --hint=int:transient:1
}

# Check if grim, slurp, and notify-send are installed
if ! command -v grim &> /dev/null || ! command -v slurp &> /dev/null || ! command -v notify-send &> /dev/null; then
    echo "Error: grim, slurp, and/or notify-send are not installed. Please install them first."
    exit 1
fi

# Parse command line arguments
case "$1" in
    -f|--full)
        file_path=$(generate_filename)
        grim "$file_path"
        ;;
    -s|--select)
        file_path=$(generate_filename)
        grim -g "$(slurp)" "$file_path"
        ;;
    -m|--monitor)
        active_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')

        # Check if the active monitor was found
        if [ -z "$active_monitor" ]; then
            echo "Error: No active monitor found."
            exit 1
        fi

        file_path=$(generate_filename)
        grim -g "$active_monitor" "$file_path"
        ;;
    -h|--help)
        usage
        ;;
    *)
        echo "Error: Invalid option"
        usage
        exit 1
        ;;
esac

# Send notification with image preview and action
send_notification "$file_path"

echo "Screenshot saved successfully in ~/Pictures/Screenshots!"
