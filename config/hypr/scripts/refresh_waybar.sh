#!/bin/bash

waybar_config="$HOME/.config/waybar/config"
waybar_style="$HOME/.config/waybar/config.css"

if [ "$(pgrep -x "waybar")" ]; then
	killall waybar && waybar -c $waybar_config -s $waybar_style
else
	waybar -c $waybar_config -s $waybar_style
fi

