#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

echo -e "${BLUE}Installing and configuring SDDM...${NC}"
sudo pacman -S --noconfirm sddm

if [ -d "$DOTFILES_DIR/sddm-theme" ]; then
    sudo cp -r "$DOTFILES_DIR/misc/sddm" /usr/share/sddm/themes/rukio
    sudo cp -r "$DOTFILES_DIR/prefs/sddm.conf" /etc/sddm.conf
fi

sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target
echo -e "${GREEN}SDDM configured successfully${NC}"
