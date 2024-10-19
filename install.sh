#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Warning message
echo -e "${YELLOW}WARNING: This installation script is designed for Arch Linux systems${NC}"
echo -e "${YELLOW}The configurations are optimized for 1366x768 displays${NC}"
echo -e "${YELLOW}Font sizes and icon sizes may vary on different resolutions${NC}"
echo "Press Enter to continue or Ctrl+C to abort..."
read

# Repository URL - Change this to your repository URL
DOTFILES_REPO="https://github.com/NotMugil/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Clone dotfiles repository
clone_dotfiles() {
    echo -e "${BLUE}Cloning dotfiles repository...${NC}"
    if [ -d "$DOTFILES_DIR" ]; then
        echo -e "${YELLOW}Dotfiles directory already exists. Removing old version...${NC}"
        mv "$DOTFILES_DIR" ".existing.dotfiles.bkp"
    fi
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to clone dotfiles repository. Exiting...${NC}"
        exit 1
    fi
}

# Function to create backup of existing configs
backup_configs() {
    backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    echo -e "${BLUE}Checking for existing configurations to backup...${NC}"
    
    # Find all directories in the dotfiles .config directory
    # These are the configs that will be installed
    local configs_to_check=($(find "$DOTFILES_DIR/.config" -maxdepth 1 -mindepth 1 -type d -printf "%f\n"))
    local backup_needed=false
    
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
}

# Function to create required directories
create_directories() {
    echo -e "${BLUE}Creating required directories...${NC}"
    directories=(
        "$HOME/.wallpapers"
        "$HOME/.themes"
        "$HOME/.fonts"
        "$HOME/.config"
        # Add more directories as needed
    )
    
    for dir in "${directories[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            echo -e "${GREEN}Created directory: $dir${NC}"
        else
            echo -e "${YELLOW}Directory already exists, skipping: $dir${NC}"
        fi
    done
}

# Function to install packages
install_packages() {
    local package_type=$1
    local log_file="$DOTFILES_DIR/installation_log.txt"
    
    # Read the package list from the dotfiles repository
    local package_file="$DOTFILES_DIR/package_list.txt"
    
    if [ ! -f "$package_file" ]; then
        echo -e "${RED}Package list file not found: $package_file${NC}"
        return 1
    }
    
    echo -e "${BLUE}Installing $package_type packages...${NC}"
    
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        
        # Split line into type and package name
        local pkg_type=$(echo "$line" | awk '{print $1}')
        local package=$(echo "$line" | awk '{print $2}')
        
        # Only process lines matching the requested package type
        if [ "$pkg_type" = "$package_type" ]; then
            if [ "$package_type" = "aur" ]; then
                yay -S --noconfirm "$package" &>/dev/null
            else
                sudo pacman -S --noconfirm "$package" &>/dev/null
            fi
            
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ $package installed successfully${NC}"
            else
                echo -e "${RED}ERROR: $package failed to install${NC}"
                echo "$(date): Failed to install $package" >> "$log_file"
            fi
        fi
    done < "$package_file"
}

# Function to handle wallpapers
setup_wallpapers() {
    echo -n "Do you want to install wallpapers? (y/N): "
    read -r install_walls
    
    if [[ "$install_walls" =~ ^[Yy]$ ]]; then
        echo "Cloning wallpapers repository..."
        git clone https://github.com/NotMugil/walls.git temp_walls
        cp -r temp_walls/* "$HOME/.wallpapers/"
        rm -rf temp_walls
        echo -e "${GREEN}Wallpapers installed successfully${NC}"

     else
            echo -e "${RED}Failed to install the wallpapers, Install it manually${NC}"
    fi
}

# Function to setup SDDM
setup_sddm() {
    echo -n "Do you want to configure SDDM? (y/N): "
    read -r configure_sddm
    
    if [[ "$configure_sddm" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Installing and configuring SDDM...${NC}"
        sudo pacman -S --noconfirm sddm
        if [ -d "$DOTFILES_DIR/misc/sddm/sddm-theme" ]; then
            sudo cp -r "$DOTFILES_DIR/misc/sddm/sddm-theme" /usr/share/sddm/themes/
            sudo cp -r "$DOTFILES_DIR/misc/sddm/sddm.conf" /etc/sddm.conf
        fi
        sudo systemctl enable sddm.service
        echo -e "${GREEN}SDDM configured successfully${NC}"
    fi
}

# Main installation process
main() {
    # First clone the dotfiles repository
    clone_dotfiles
    
    # Create backup of existing configs
    backup_configs
    
    # Create necessary directories
    create_directories
    
    # Install packages
    install_packages "pacman"
    install_packages "aur"
    
    # Copy configurations
    echo -e "${BLUE}Copying configurations...${NC}"
    if [ -d "$DOTFILES_DIR/.config" ]; then
        cp -r "$DOTFILES_DIR/.config"/* "$HOME/.config/"
        echo -e "${GREEN}Configurations copied successfully${NC}"
    fi
    
    # Setup wallpapers
    setup_wallpapers
    
    # Setup SDDM
    setup_sddm
    
    echo -e "${GREEN}Installation completed! Please log out and log back in to apply changes.${NC}"
}

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: This script requires Arch Linux${NC}"
    exit 1
fi

# Check if yay is installed for AUR packages
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Warning: yay is not installed. Installing yay...${NC}"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Run the main installation
main
