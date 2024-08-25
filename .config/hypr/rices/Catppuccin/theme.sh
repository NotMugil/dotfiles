#!/bin/bash

set -e

THEME="Starlit"
WAYBAR_THEME="spectrum"
GTK_THEME="catppuccin-mocha-blue-standard+default"

WALLPAPERS_DIR="$HOME/.wallpapers"
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_STYLES_DIR="$HOME/.config/waybar/styles"
HYPR_CONF="$HOME/.config/hypr/configs"

SWWW_PARAMS="--transition-fps 60 --transition-type any --transition-duration 1.5 --transition-bezier 0.4,0.2,0.4,1.0"

BASE_DIR="$(dirname "$0")"
WALLPAPERS_SRC="$BASE_DIR/wallpapers"

notify_error() {
    local message="$1"
    notify-send -u critical -t 2000 "Script Error" "$message" || echo "Failed to send notification: $message"
}

set_wallpaper() {
    if [[ -L "$WALLPAPERS_DIR" ]]; then
        echo "Removing symlink $WALLPAPERS_DIR."
        rm "$WALLPAPERS_DIR" || { notify_error "Error removing symlink $WALLPAPERS_DIR"; exit 1; }
    elif [[ -d "$WALLPAPERS_DIR" ]]; then
        echo "Removing directory $WALLPAPERS_DIR."
        rm -r "$WALLPAPERS_DIR" || { notify_error "Error removing directory $WALLPAPERS_DIR"; exit 1; }
    fi

    echo "Creating symlink $WALLPAPERS_DIR."
    ln -sf "$WALLPAPERS_SRC" "$WALLPAPERS_DIR" || { notify_error "Error creating symlink $WALLPAPERS_DIR"; exit 1; }

    echo "Setting wallpaper."
    if [[ -f "$WALLPAPERS_DIR/01.webp" ]]; then
        swww img "$WALLPAPERS_DIR/01.webp" ${SWWW_PARAMS} || { notify_error "Error setting wallpaper"; exit 1; }
        ln -sf "$WALLPAPERS_DIR/01.webp" "$HOME/.current_wallpaper" || { notify_error "Error creating wallpaper symlink"; exit 1; }
    else
        notify_error "Wallpaper not found: $WALLPAPERS_DIR/01.webp"
        exit 1
    fi
}

set_hypr_config() {
    echo "Linking config files."
    ln -sf "$BASE_DIR/theme.conf" "$HYPR_CONF/theme.conf" || { notify_error "Error linking theme.conf"; exit 1; }
    ln -sf "$BASE_DIR/colors.conf" "$HYPR_CONF/colors.conf" || { notify_error "Error linking colors.conf"; exit 1; }
}

set_kitty_config() {
    echo "Setting kitty config."
    kitten themes --reload-in=all $THEME
}

set_gtk_theme() {
    echo "Setting GTK theme to $GTK_THEME."

    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" || { notify_error "Error setting GTK theme"; exit 1; }
    gsettings set org.gnome.desktop.wm.preferences theme "$GTK_THEME" || { notify_error "Error setting GTK window manager theme"; exit 1; }
}

set_waybar() {
    echo "Setting waybar config"
    ln -sf "$WAYBAR_STYLES_DIR/$WAYBAR_THEME/config.jsonc" "$WAYBAR_DIR/config.jsonc" || { notify_error "Error linking waybar config.jsonc"; exit 1; }
    ln -sf "$WAYBAR_STYLES_DIR/$WAYBAR_THEME/style.css" "$WAYBAR_DIR/style.css" || { notify_error "Error linking waybar style.css"; exit 1; }

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
