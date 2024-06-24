#!/bin/bash

ROFI_DIR="$HOME/.config/rofi"
THEMES_DIR="/usr/share/themes"
gtk4="$HOME/.config/gtk-4.0"
xsettings="$HOME/.config/xsettingsd/xsettingsd.conf"

# Function to apply Latte theme with selected color
apply_latte_theme() {
	local color="$1"
	echo "Applying $color Latte theme"

	# Commands to apply GTK Theme
	gsettings set org.gnome.desktop.interface gtk-theme catppuccin-latte-$color-standard+default
        ln -sf /usr/share/themes/catppuccin-latte-$color-standard+default/gtk-4.0 ~/.config
	sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"catppuccin-latte-$color-standard+default\"/g" ~/.config/xsettingsd/xsettingsd.conf
	pkill xsettingsd
      	xsettingsd &

	# Commands to apply waybar theme	
	ln -sf ~/.config/waybar/colors/catppuccin-latte.css ~/.config/waybar/colors/current-theme.css
	pkill waybar
	waybar &

 	# Kitty
	kitten themes --reload-in=all Catppuccin-Latte

	# Commands to apply spicetify color
	spicetify config color_scheme CatppuccinLatte
	spicetify apply

}

# Function to apply Frappe theme with selected color
apply_frappe_theme() {
	local color="$1"
	echo "Applying $color Frappe theme"

	# Commands to apply GTK Theme
	gsettings set org.gnome.desktop.interface gtk-theme catppuccin-frappe-$color-standard+default
        ln -sf /usr/share/themes/catppuccin-frappe-$color-standard+default/gtk-4.0 ~/.config	
	sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"catppuccin-frappe-$color-standard+default\"/g" ~/.config/xsettingsd/xsettingsd.conf
	pkill xsettingsd
      	xsettingsd &

	# Kitty
	kitten themes --reload-in=all Catppuccin-Frappe

	# Commands to apply waybar theme
	ln -sf ~/.config/waybar/colors/catppuccin-frappe.css ~/.config/waybar/colors/current-theme.css
	pkill waybar
	waybar &

	# Commands to apply spicetify color
	spicetify config color_scheme CatppuccinLatte
	spicetify apply

}

# Functicaon to apply Macchiato theme with selected color
apply_macchiato_theme() {
	local color="$1"
	echo "Applying $color Macchiato theme"

	
	# Commands to apply GTK Theme
	gsettings set org.gnome.desktop.interface gtk-theme catppuccin-macchiato-$color-standard+default
        ln -sf /usr/share/themes/catppuccin-macchiato-$color-standard+default/gtk-4.0 ~/.config
	sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"catppuccin-macchiato-$color-standard+default\"/g" ~/.config/xsettingsd/xsettingsd.conf
	pkill xsettingsd
      	xsettingsd &

	# Commands to apply waybar theme
	ln -sf ~/.config/waybar/colors/catppuccin-macchiato.css ~/.config/waybar/colors/current-theme.css
	pkill waybar
	waybar &
	
	# Kitty
	kitten themes --reload-in=all Catppuccin-Macchiato

	# Commands to apply spicetify color
	spicetify config color_scheme CatppuccinMacchiato
	spicetify apply
}

# Function to apply Mocha theme with selected color
apply_mocha_theme() {
	local color="$1"
	echo "Applying $color Mocha theme"

	
	# Commands to apply GTK Theme
	gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-$color-standard+default
        ln -sf /usr/share/themes/catppuccin-mocha-$color-standard+default/gtk-4.0 ~/.config
	sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"catppuccin-mocha-$color-standard+default\"/g" ~/.config/xsettingsd/xsettingsd.conf
	pkill xsettingsd
      	xsettingsd &

	# Kitty
	kitten themes --reload-in=all Catppuccin-Mocha

	# Commands to apply waybar theme
	ln -sf ~/.config/waybar/colors/catppuccin-mocha.css ~/.config/waybar/colors/current-theme.css
	pkill waybar
	waybar &

	# Commands to apply spicetify color
	spicetify config color_scheme CatppuccinMocha
	spicetify apply

}

# Array of color options
colors=("blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow")

# Array of theme options
themes=("latte" "frappe" "macchiato" "mocha")

# Use Rofi to select theme
selected_theme=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -theme $ROFI_DIR/theme.rasi -p "Select a theme:")

# Use Rofi to select color
selected_color=$(printf '%s\n' "${colors[@]}" | rofi -dmenu -theme $ROFI_DIR/theme.rasi -p "Select a color for $selected_theme theme:")

# If no color is selected, set default color to "blue"
if [[ -z "$selected_color" ]]; then
    selected_color="blue"
fi

# Determine which theme function to call based on user selection
case $selected_theme in
    "latte")
        apply_latte_theme "$selected_color"
        ;;
    "frappe")
        apply_frappe_theme "$selected_color"
        ;;
    "macchiato")
        apply_macchiato_theme "$selected_color"
        ;;
    "mocha")
        apply_mocha_theme "$selected_color"
        ;;
    *)
        echo "Invalid selection or no theme chosen."
        exit 1
        ;;
esac

# Add more commands/functions as needed to apply the theme with selected color across different applications.
