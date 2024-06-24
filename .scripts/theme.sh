#!/bin/bash

# Define constants for themes
THEME_1="theme1"
THEME_2="theme2"
THEME_3="theme3"
THEME_4="theme4"

# Define theme-specific settings (replace with actual themes and settings)
THEME_1_GTK_THEME="Orchis-Light-Compact"
THEME_1_COLOR_SCHEME="prefer-light"
THEME_1_WALLPAPER="$HOME/.wallpapers/theme1.jpg"
THEME_1_WAYBAR_THEME="theme1.css"
THEME_1_KITTY_THEME="Catppuccin-Latte"

THEME_2_GTK_THEME="Another-Theme"
THEME_2_COLOR_SCHEME="another-color-scheme"
THEME_2_WALLPAPER="$HOME/.wallpapers/theme2.jpg"
THEME_2_WAYBAR_THEME="theme2.css"
THEME_2_KITTY_THEME="Another-Kitty-Theme"

THEME_3_GTK_THEME="Third-Theme"
THEME_3_COLOR_SCHEME="third-color-scheme"
THEME_3_WALLPAPER="$HOME/.wallpapers/theme3.jpg"
THEME_3_WAYBAR_THEME="theme3.css"
THEME_3_KITTY_THEME="Third-Kitty-Theme"

THEME_4_GTK_THEME="Fourth-Theme"
THEME_4_COLOR_SCHEME="fourth-color-scheme"
THEME_4_WALLPAPER="$HOME/.wallpapers/theme4.jpg"
THEME_4_WAYBAR_THEME="theme4.css"
THEME_4_KITTY_THEME="Fourth-Kitty-Theme"

# Function to apply GTK theme and color scheme
apply_gtk_theme() {
    local theme="$1"
    local color_scheme="$2"

    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
    gsettings set org.gnome.desktop.interface cursor-theme "$theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$theme"
    gsettings set org.gnome.desktop.interface icon-theme "$theme"
    gsettings set org.gnome.desktop.interface cursor-theme "$theme"
    gsettings set org.gnome.desktop.interface icon-theme "$theme"
}

# Function to switch Waybar theme
switch_waybar_theme() {
    local theme="$1"

    ln -sf "$WAYBAR_CONFIG_DIR/themes/$theme" "$WAYBAR_CONFIG_DIR/style.css"
    ~/.scripts/refresh_waybar.sh
}

# Function to apply wallpaper
apply_wallpaper() {
    local wallpaper="$1"

    swww img "$wallpaper" --transition-type any
}

# Function to switch theme based on Rofi selection
switch_theme() {
    local theme_number="$1"

    case "$theme_number" in
        1)
            apply_gtk_theme "$THEME_1_GTK_THEME" "$THEME_1_COLOR_SCHEME"
            switch_waybar_theme "$THEME_1_WAYBAR_THEME"
            apply_wallpaper "$THEME_1_WALLPAPER"
            kitten themes --reload-in=all "$THEME_1_KITTY_THEME"
            ;;
        2)
            apply_gtk_theme "$THEME_2_GTK_THEME" "$THEME_2_COLOR_SCHEME"
            switch_waybar_theme "$THEME_2_WAYBAR_THEME"
            apply_wallpaper "$THEME_2_WALLPAPER"
            kitten themes --reload-in=all "$THEME_2_KITTY_THEME"
            ;;
        3)
            apply_gtk_theme "$THEME_3_GTK_THEME" "$THEME_3_COLOR_SCHEME"
            switch_waybar_theme "$THEME_3_WAYBAR_THEME"
            apply_wallpaper "$THEME_3_WALLPAPER"
            kitten themes --reload-in=all "$THEME_3_KITTY_THEME"
            ;;
        4)
            apply_gtk_theme "$THEME_4_GTK_THEME" "$THEME_4_COLOR_SCHEME"
            switch_waybar_theme "$THEME_4_WAYBAR_THEME"
            apply_wallpaper "$THEME_4_WALLPAPER"
            kitten themes --reload-in=all "$THEME_4_KITTY_THEME"
            ;;
        *)
            echo "Invalid theme number"
            ;;
    esac
}

# Main logic: Prompt user to select a theme using Rofi
selected_theme=$(echo -e "$THEME_1\n$THEME_2\n$THEME_3\n$THEME_4" | rofi -dmenu -p "Select a theme:")

# Check if a theme was selected and switch accordingly
if [ -n "$selected_theme" ]; then
    case "$selected_theme" in
        "$THEME_1" | "$THEME_2" | "$THEME_3" | "$THEME_4")
            switch_theme "$selected_theme"
            ~/.scripts/combine_configs.sh "$selected_theme"  # Adjust as per your configuration merging script
            ;;
        *)
            echo "Invalid theme selection"
            ;;
    esac
else
    echo "No theme selected"
fi
