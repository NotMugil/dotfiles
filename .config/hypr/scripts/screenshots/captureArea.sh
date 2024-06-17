#!/bin/bash

grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png') && notify-send -e "Screenshot taken" -i /usr/share/icons/Papirus-Dark/22x22/devices/camera-photo.svg

play ~/.config/hypr/assets/sounds/camera-shutter.ogg
