#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

echo -e "${BLUE}Copying configurations...${NC}"
if [ -d "$DOTFILES_DIR/dots/.config" ]; then
    cp -r "$DOTFILES_DIR/dots/.config"/* "$HOME/.config/"
    echo -e "${GREEN}Configurations copied successfully${NC}"
fi
