#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
echo -e "${BLUE}Checking for existing configurations to backup...${NC}"

configs_to_check=($(find "$DOTFILES_DIR/dots/.config" -maxdepth 1 -mindepth 1 -type d -printf "%f\n"))
backup_needed=false

for config in "${configs_to_check[@]}"; do
    if [ -d "$HOME/.config/$config" ]; then
        if [ "$backup_needed" = false ]; then
            echo "Creating backup directory: $backup_dir"
            mkdir -p "$backup_dir"
            backup_needed=true
        fi
        echo "Backing up existing config: $config"
        cp -r "$HOME/.config/$config" "$backup_dir/"
    fi
done

if [ "$backup_needed" = true ]; then
    echo -e "${GREEN}Backup completed in: $backup_dir${NC}"
else
    echo -e "${BLUE}No existing configurations found that need backup${NC}"
fi
