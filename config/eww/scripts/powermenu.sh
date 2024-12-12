#!/bin/sh

LOCK=/home/$USER/.config/eww/power.lock
eww=/home/$USER/.local/bin/eww

if [ -f "$LOCK" ]; then
    rm -rf "$LOCK"
    $eww close powercenter
else
    touch "$LOCK"
    $eww open powercenter
fi
