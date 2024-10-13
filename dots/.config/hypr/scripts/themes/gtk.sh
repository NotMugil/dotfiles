#!/bin/bash

theme=$1

set_theme() {
    gsettings set org.gnome.desktop.interface gtk-theme "$1"
    gsettings set org.gnome.desktop.interface icon-theme "$2"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
}

case "$theme" in
    "Catppuccin")
        gtk3_theme="catppuccin-mocha-blue-standard+default"
        icon_theme="Colloid-Grey-Catppuccin"
        ;;
    "Tokyo-Night")
        gtk3_theme="Tokyonight-Dark"
        icon_theme="Tokyonight-Moon"
        ;;
    "Gruvbox-Dark")
        gtk3_theme="Gruvbox-Dark"
        icon_theme="Colloid-Teal-Gruvbox"
        ;;
    "Starlit")
        gtk3_theme="Starlit-GTK3"
        icon_theme="Colloid-Dark"
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for GTK: $theme"
        exit 1
        ;;
esac

set_theme "$gtk3_theme" "$icon_theme"

echo "GTK theme changed to: $theme"
