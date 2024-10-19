#!/bin/bash

# Source common variables if not already sourced
[[ -z "$DOTFILES_DIR" ]] && source "$(dirname "$0")/variables.sh"

# Check and install yay if needed
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Installing yay...${NC}"
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd .. && rm -rf yay
fi

package_file="$DOTFILES_DIR/package_list.txt"

if [ ! -f "$package_file" ]; then
    echo -e "${RED}Package list file not found: $package_file${NC}"
    exit 1
fi

# Install pacman packages
echo -e "${BLUE}Installing pacman packages...${NC}"
while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    type=$(echo "$line" | awk '{print $1}')
    package=$(echo "$line" | awk '{print $2}')
    
    if [ "$type" = "pacman" ]; then
        sudo pacman -S --noconfirm "$package" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ $package installed successfully${NC}"
        else
            echo -e "${RED}ERROR: $package failed to install${NC}"
            echo "$(date): Failed to install $package" >> "$LOG_FILE"
        fi
    fi
done < "$package_file"

# Install AUR packages
echo -e "${BLUE}Installing AUR packages...${NC}"
while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    type=$(echo "$line" | awk '{print $1}')
    package=$(echo "$line" | awk '{print $2}')
    
    if [ "$type" = "aur" ]; then
        yay -S --noconfirm "$package" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ $package installed successfully${NC}"
        else
            echo -e "${RED}ERROR: $package failed to install${NC}"
            echo "$(date): Failed to install $package" >> "$LOG_FILE"
        fi
    fi
done < "$package_file"
