#!/bin/bash

# Source common variables
source "$(dirname "$0")/scripts/variables.sh"

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: This script requires Arch Linux${NC}"
    exit 1
fi

# Show welcome message
echo -e "${YELLOW}WARNING: This installation script is designed for Arch Linux systems${NC}"
echo -e "${YELLOW}The configurations are optimized for 1366x768 displays${NC}"
echo -e "${YELLOW}Font sizes and icon sizes may vary on different resolutions${NC}"
echo "Press Enter to continue or Ctrl+C to abort..."
read

# Clone dotfiles repository first
echo -e "${BLUE}Cloning dotfiles repository...${NC}"
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Dotfiles directory already exists. Removing old version...${NC}"
    rm -rf "$DOTFILES_DIR"
fi
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to clone dotfiles repository. Exiting...${NC}"
    exit 1
fi

# Get user preferences
echo -e "${BLUE}Please answer the following questions to customize your installation:${NC}"

read -p "Do you want to backup existing configurations? (Y/n): " backup_choice
read -p "Do you want to install required packages? (Y/n): " packages_choice
read -p "Do you want to install wallpapers? (Y/n): " wallpapers_choice
read -p "Do you want to configure SDDM? (Y/n): " sddm_choice

# Execute installation steps based on user choices
echo -e "\n${BLUE}Starting installation...${NC}\n"

# Create directories
source "$(dirname "$0")/scripts/directories.sh"

# Backup if requested
if [[ -z "$backup_choice" || "$backup_choice" =~ ^[Yy]$ ]]; then
    source "$(dirname "$0")/scripts/backup.sh"
fi

# Install packages if requested
if [[ -z "$packages_choice" || "$packages_choice" =~ ^[Yy]$ ]]; then
    source "$(dirname "$0")/scripts/packages.sh"
fi

# Install wallpapers if requested
if [[ -z "$wallpapers_choice" || "$wallpapers_choice" =~ ^[Yy]$ ]]; then
    source "$(dirname "$0")/scripts/wallpapers.sh"
fi

# Configure SDDM if requested
if [[ -z "$sddm_choice" || "$sddm_choice" =~ ^[Yy]$ ]]; then
    source "$(dirname "$0")/scripts/sddm.sh"
fi

# Copy configurations
source "$(dirname "$0")/scripts/configs.sh"

echo -e "\n${GREEN}Installation completed! Please log out and log back in to apply changes.${NC}"
