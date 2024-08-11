#!/bin/bash

# Define directories and files

THEME="Rosé"
WAYBAR_THEME="hollow"
GTK_THEME="Adwaita-dark"


WALLPAPERS_DIR="$HOME/.wallpapers"
WAYBAR_DIR="$HOME/.config/waybar"
WAYBAR_STYLES_DIR="$HOME/.config/waybar/styles"
HYPR_CONF="$HOME/.config/hypr/configs"
SWWW_PARAMS="--transition-fps 60 --transition-type any --transition-duration 1.5 --transition-bezier 0.4,0.2,0.4,1.0"

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
        notify-send "Wallpaper Changed" -i "$WALLPAPERS_DIR/01.webp"
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

set_kitty_config(){
    echo "Setting kitty config."

    # Define the path to the theme-specific kitty configuration file
    THEME_KITTY_CONF="$HOME/.config/hypr/rices/$THEME/kitty-theme.conf"
    KITTY_CONF_DIR="$HOME/.config/kitty"
    KITTY_CONF="$KITTY_CONF_DIR/kitty.conf"

    # Check if the kitty configuration directory exists
    if [[ ! -d "$KITTY_CONF_DIR" ]]; then
        echo "Kitty configuration directory does not exist. Creating it."
        mkdir -p "$KITTY_CONF_DIR" || { echo "Error creating kitty configuration directory"; exit 1; }
    fi

    # Remove old kitty.conf if it exists
    if [[ -f "$KITTY_CONF" ]]; then
        echo "Removing old kitty configuration file."
        rm "$KITTY_CONF" || { echo "Error removing old kitty configuration file"; exit 1; }
    else
        echo "No existing kitty configuration file to remove."
    fi

    # Check if the theme-specific kitty configuration file exists
    if [[ -f "$THEME_KITTY_CONF" ]]; then
        echo "Creating symlink to new kitty configuration file."
        ln -sf "$THEME_KITTY_CONF" "$KITTY_CONF" || { echo "Error creating symlink for kitty configuration"; exit 1; }
    else
        echo "Theme-specific kitty configuration file not found: $THEME_KITTY_CONF"
        exit 1
    fi

    # Notify kitty to reload configuration
    if pgrep -x kitty > /dev/null; then
        echo "Kitty is running. Attempting to reload configuration."
        kitty @ set-colors --all "$KITTY_CONF" || { echo "Error reloading kitty configuration"; exit 1; }
    else
        echo "Kitty is not running. Launching kitty with new config."
        kitty &
    fi
}

set_gtk_theme() {
    echo "Setting GTK theme to $GTK_THEME."

    # Update GTK 3 and GTK 4 configurations
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
    gsettings set org.gnome.desktop.wm.preferences theme "$GTK_THEME"

    # Notify user
    notify-send "GTK Theme Changed" "Theme set to $GTK_THEME"

    # Restart applications to apply changes
    pkill -HUP gnome-shell
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

# Run all tasks
main() {
    set_wallpaper
    set_hypr_config
    set_waybar
    set_kitty_config
    set_gtk_theme
}

# Execute main function
main
