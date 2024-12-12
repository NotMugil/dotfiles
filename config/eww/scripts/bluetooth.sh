#!/bin/bash
getIcon() {
    local blocked=$(rfkill list bluetooth | grep "Soft blocked" | awk '{print $3}')
    local power=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
    local devices=$(bluetoothctl devices Connected)

    if [[ "$blocked" == "yes" ]]; then
        echo "󰂲"
    elif [[ "$power" == "no" ]]; then
        echo "󰂲"
    elif [[ -z "$devices" ]]; then
        echo "󰂯"
    else
        echo "󰂱"
    fi
}

getColor() {
    local devices=$(bluetoothctl devices Connected)
    local device_count=$(echo "$devices" | grep -c "Device")

    if [[ $device_count -eq 0 ]]; then
        echo "#a6a6a6"
    else
        echo "#FFFFFF"
    fi
}

main() {
    local blocked=$(rfkill list bluetooth | grep "Soft blocked" | awk '{print $3}')
    local power=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
    local devices=$(bluetoothctl devices Connected)
    local device_count=$(echo "$devices" | grep -c "Device")
    local icon=$(getIcon)
    local color=$(getColor)
    local status="off"

    if [[ "$blocked" == "yes" ]]; then
        status="blocked"
        device_count=0
    elif [[ "$power" == "yes" ]]; then
        if [[ -z "$devices" ]]; then
            status="on"
            device_count=0
        else
            status="connected"
        fi
    fi

    printf '{"status": "%s", "devices": %d, "icon": "%s", "color": "%s"}' \
        "$status" "$device_count" "$icon" "$color"
}
main
