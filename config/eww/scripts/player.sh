#!/bin/sh

LOCK=/home/$USER/.config/eww/pm.lock
eww=/home/$USER/.local/bin/eww

if [ -f "$LOCK" ]; then
    rm -rf "$LOCK"
    $eww close player
else
    touch "$LOCK"
    $eww open player
fi
