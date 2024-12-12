#!/bin/bash

getNetwork() {
    local wifi_status=$(nmcli networking connectivity)
    local wifi_interface=$(ip route | awk '/default/ {print $5}')

    # Check if wifi is connected
    if [[ "$wifi_status" == "full" ]]; then
        local wifi_name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
        local signal_strength=$(cat /proc/net/wireless | awk -v iface="$wifi_interface" '$1 == iface":" {print int($3 * 100 / 70)}')

        if [[ -z "$wifi_name" ]]; then
            # Ethernet connection
            echo '{"status": "connected", "type": "ethernet", "icon": "󰈀"}'
        else
            # WiFi connection
            if [[ $signal_strength -ge 75 ]]; then
                echo '{"status": "connected", "type": "wifi", "name": "'"$wifi_name"'", "icon": "󰤨"}'
            elif [[ $signal_strength -ge 50 ]]; then
                echo '{"status": "connected", "type": "wifi", "name": "'"$wifi_name"'", "icon": "󰤥"}'
            elif [[ $signal_strength -ge 25 ]]; then
                echo '{"status": "connected", "type": "wifi", "name": "'"$wifi_name"'", "icon": "󰤢"}'
            else
                echo '{"status": "connected", "type": "wifi", "name": "'"$wifi_name"'", "icon": "󰤟"}'
            fi
        fi
    else
        echo '{"status": "disconnected", "type": "none", "icon": "󰖪"}'
    fi
}

getNetwork
