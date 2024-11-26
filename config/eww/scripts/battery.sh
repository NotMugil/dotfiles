#!/bin/bash

get_battery_status() {
    # Find battery device
    local battery_device=""
    for potential_device in /sys/class/power_supply/BAT*; do
        if [ -f "$potential_device/capacity" ] && [ -f "$potential_device/status" ]; then
            battery_device="$potential_device"
            break
        fi
    done

    if [ -z "$battery_device" ]; then
        echo '{"percentage": 0, "status": "Unknown"}'
        return 1
    fi

    # Read battery capacity and charging status
    local percentage=$(cat "$battery_device/capacity")
    local status=$(cat "$battery_device/status")

    # Output JSON
    printf '{"percentage": %d, "status": "%s"}\n' "$percentage" "$status"
}

# Continuously output status
while true; do
    get_battery_status
    sleep 2
done
