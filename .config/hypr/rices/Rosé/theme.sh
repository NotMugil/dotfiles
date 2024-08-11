#!/bin/bash

set -e

THEME="Rosé"
WAYBAR_THEME="hollow"
GTK_THEME="Adwaita-dark"

WALLPAPERS_DIR="$HOME/.wallpapers"
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_STYLES_DIR="$HOME/.config/waybar/styles"
HYPR_CONF="$HOME/.config/hypr/configs"
SCRIPTS_DIR="$HOME/.config/hypr/scripts"
SWWW_PARAMS="--transition-fps 60 --transition-type any --transition-duration 1.5 --transition-bezier 0.4,0.2,0.4,1.0"

BASE_DIR="$(dirname "$0")"
WALLPAPERS_SRC="$BASE_DIR/wallpapers"

notify_error() {
    local message="$1"
    notify-send -u critical -t 5000 "Script Error" "$message"
}

set_wallpaper() {
    if [[ -L "$WALLPAPERS_DIR" ]]; then
        rm "$WALLPAPERS_DIR"
    elif [[ -d "$WALLPAPERS_DIR" ]]; then
        rm -r "$WALLPAPERS_DIR"
    fi

    ln -sf "$WALLPAPERS_SRC" "$WALLPAPERS_DIR"

    if [[ -f "$WALLPAPERS_DIR/01.webp" ]]; then
        swww img "$WALLPAPERS_DIR/01.webp" ${SWWW_PARAMS}
        ln -sf "$WALLPAPERS_DIR/01.webp" "$HOME/.current_wallpaper"
    else
        notify_error "Wallpaper not found: $WALLPAPERS_DIR/01.webp"
        exit 1
    fi
}

set_hypr_config() {
    ln -sf "$BASE_DIR/theme.conf" "$HYPR_CONF/theme.conf"
    ln -sf "$BASE_DIR/colors.conf" "$HYPR_CONF/colors.conf"
}

set_kitty_config() {
    echo "Setting kitty config."
    kitten themes --reload-in=all $THEME
}

set_gtk_theme() {
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
    gsettings set org.gnome.desktop.wm.preferences theme "$GTK_THEME"
}

set_waybar() {
    ln -sf "$WAYBAR_STYLES_DIR/$WAYBAR_THEME/config.jsonc" "$WAYBAR_DIR/config.jsonc"
    ln -sf "$WAYBAR_STYLES_DIR/$WAYBAR_THEME/style.css" "$WAYBAR_DIR/style.css"

    if pgrep -x "waybar"; then
        pkill -x waybar
        waybar &
    else
        waybar &
    fi
}

main() {
    set_wallpaper || { notify_error "Failed to set wallpaper"; exit 1; }
    set_gtk_theme || { notify_error "Failed to set GTK theme"; exit 1; }
    set_kitty_config || { notify_error "Failed to set Kitty configuration"; exit 1; }
    set_hypr_config || { notify_error "Failed to set Hypr configuration"; exit 1; }
    set_waybar || { notify_error "Failed to set Waybar configuration"; exit 1; }
}

main
