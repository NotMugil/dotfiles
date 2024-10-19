#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

if [ -d "$DOTFILES_DIR/wallpapers" ]; then
    echo -e "${BLUE}Copying wallpapers...${NC}"
    git clone https://github.com/NotMugil/walls.git "$HOME/walls"
    cp -r "$HOME/walls/*" "$HOME/.wallpapers"
    rm -rf "$HOME/walls"
    echo -e "${GREEN}Wallpapers installed successfully${NC}"
else
    echo -e "${RED}Wallpapers directory not found in dotfiles${NC}"
fi
