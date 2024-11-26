#!/bin/bash

get_brightness_status() {
    # Try to find a valid backlight device
    local device=""
    for potential_device in /sys/class/backlight/*; do
        if [ -f "$potential_device/brightness" ] && [ -f "$potential_device/max_brightness" ]; then
            device="$potential_device"
            break
        fi
    done

    if [ -z "$device" ]; then
        echo '{"brightness": 0, "current": 0, "max": 1}'
        return 1
    fi

    # Read current and max brightness, use 'cat' to ensure we get the values
    local current=$(cat "$device/brightness")
    local max=$(cat "$device/max_brightness")

    # Prevent division by zero using awk for safe arithmetic
    local percentage=$(awk -v curr="$current" -v max="$max" 'BEGIN {
        if (max > 0) printf "%.0f", (curr / max) * 100
        else print 0
    }')

    # Output JSON
    echo "{\"brightness\": $percentage, \"current\": $current, \"max\": $max}"
}

# Continuously output status
while true; do
    get_brightness_status
    sleep 2
done
