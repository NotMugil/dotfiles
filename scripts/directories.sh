#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

echo -e "${BLUE}Creating required directories...${NC}"
directories=(
    "$HOME/.wallpapers"
    "$HOME/.themes"
    "$HOME/.fonts"
    "$HOME/.config"
)

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}Created directory: $dir${NC}"
    else
        echo -e "${YELLOW}Directory already exists, skipping: $dir${NC}"
    fi
done
