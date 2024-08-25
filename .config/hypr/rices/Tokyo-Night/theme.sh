#!/bin/bash

# Define directories and files

THEME="Overdrive"
WAYBAR_THEME="rift"
GTK_THEME="Adwaita-dark"


WALLPAPERS_DIR="$HOME/.wallpapers"
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_STYLES_DIR="$HOME/.config/waybar/styles"
HYPR_CONF="$HOME/.config/hypr/configs"
SCRIPTS_DIR="$HOME/.config/hypr/scripts"
SWWW_PARAMS="--transition-fps 60 --transition-type wipe --transition-duration 1.5 --transition-bezier 0.4,0.2,0.4,1.0"

# Get the base directory
BASE_DIR="$(dirname "$0")"
WALLPAPERS_SRC="$BASE_DIR/wallpapers"

# Set up wallpaper directory and change wallpaper
set_wallpaper() {
    # Remove old wallpaper symlink or directory
    if [[ -L "$WALLPAPERS_DIR" ]]; then
        echo "Removing symlink $WALLPAPERS_DIR."
        rm "$WALLPAPERS_DIR" || { echo "Error removing symlink"; exit 1; }
    elif [[ -d "$WALLPAPERS_DIR" ]]; then
        echo "Removing directory $WALLPAPERS_DIR."
        rm -r "$WALLPAPERS_DIR" || { echo "Error removing directory"; exit 1; }
    fi

    # Create new symlink to wallpaper directory
    echo "Creating symlink $WALLPAPERS_DIR."
    ln -sf "$WALLPAPERS_SRC" "$WALLPAPERS_DIR" || { echo "Error creating symlink"; exit 1; }

    # Set the default wallpaper
    echo "Setting wallpaper."
    if [[ -f "$WALLPAPERS_DIR/01.webp" ]]; then
        swww img "$WALLPAPERS_DIR/01.webp" ${SWWW_PARAMS} || { echo "Error setting wallpaper"; exit 1; }
        ln -sf "$WALLPAPERS_DIR/01.webp" "$HOME/.current_wallpaper" || { echo "Error creating wallpaper symlink"; exit 1; }
    else
        echo "Wallpaper not found."
        exit 1
    fi
}

# Link theme config files
set_hypr_config() {
    echo "Linking config files."
    ln -sf "$BASE_DIR/theme.conf" "$HYPR_CONF/theme.conf" || { echo "Error linking theme.conf"; exit 1; }
    ln -sf "$BASE_DIR/colors.conf" "$HYPR_CONF/colors.conf" || { echo "Error linking colors.conf"; exit 1; }
}

set_kitty_config() {
    echo "Setting kitty config."
    kitten themes --reload-in=all $THEME
}


set_gtk_theme() {
    echo "Setting GTK theme to $GTK_THEME."

    # Update GTK 3 and GTK 4 configurations
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
    gsettings set org.gnome.desktop.wm.preferences theme "$GTK_THEME"
}

set_waybar(){
    echo "Setting waybar config"
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
    set_wallpaper
    set_gtk_theme
    set_kitty_config
    set_hypr_config
    set_waybar
}

# Execute main function
main
