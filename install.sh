#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

# Function to print error messages
error() {
    echo "Error: $1" >&2
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: $1" >> "$LOG_FILE"
}

# Function to print info messages
info() {
    echo "Info: $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Info: $1" >> "$LOG_FILE"
}

display_logo() {
    # Define colors
    local RED="\033[31m"
    local GREEN="\033[32m"
    local YELLOW="\033[33m"
    local BLUE="\033[34m"
    local MAGENTA="\033[35m"
    local CYAN="\033[36m"
    local RESET="\033[0m"

    cat << "EOF"
                     __..,,__　　　,.｡='`1
         .,,..;~`''''　　　　`''''＜``彡　}
     _...:=,`'　　 　︵　 т　︵　　X彡-J
    ＜`　彡 /　　ミ　　,_人_.　＊彡　`~
     `~=::　　　 　　　　　　 　　　Y
        i.　　　　　　　　　　　　 .:
        .\　　　　　　　,｡---.,,　　./
        　　ヽ　／ﾞ''```\;.{　　　 ＼／
         　　Y　　　`J💕r_.彳　 　|
          　{　　　``　　`　　　i
          　\　　　　　　　　　＼　　　..︵︵.
          　`＼　　　　　　　　　``ゞ.,/` oQ o`)
           　`i,　　　　　　　　　　Y　 ω　/
              `i,　　　 　　.　　　　"　　　/
              `iミ　　　　　　　　　　　,,ノ
               ︵Y..︵.,,　　　　　,,+..__ノ``
              (,`, З о　　　　,.ノ川彡ゞ彡
EOF

echo


    printf "\n"
    printf "${YELLOW}Welcome to NotMugil's Dotfiles Installation Script (For Arch Linux systems)${RESET}\n"
    printf "\n"
    printf "${MAGENTA}NOTE: You will be prompted with some questions during the installation process${RESET}\n"
    printf "\n"
    printf "${MAGENTA}NOTE: If you are running on VM, enable 3D Acceleration else Hyprland won't start.${RESET}\n"
    printf "\n"
}

# Function to confirm with the user before proceeding
confirm_proceed() {
    local prompt="$1"
    local default="$2"
    local reply

    read -p "$prompt [$default]: " reply
    if [[ "${reply:-$default}" != "yes" ]]; then
        info "Installation aborted by user."
        exit 0
    fi
}

# Function to get user input
get_input() {
    local prompt="$1"
    local default="$2"
    local reply

    read -p "$prompt [$default]: " reply
    echo "${reply:-$default}"
}

# Initialize log file
LOG_FILE="$HOME/dotfiles_installation.log"
echo "Dotfiles Installation Log - $(date '+%Y-%m-%d %H:%M:%S')" > "$LOG_FILE"

# Function to check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Function to install packages with pacman
install_packages() {
    local packages_to_install=()
    local failed_packages=()
    for pkg in "$@"; do
        if is_installed "$pkg"; then
            info "Package $pkg is already installed. Skipping."
        else
            packages_to_install+=("$pkg")
        fi
    done
    if [ ${#packages_to_install[@]} -ne 0 ]; then
        info "Installing pacman packages: ${packages_to_install[*]}"
        for pkg in "${packages_to_install[@]}"; do
            if sudo pacman -S --needed --noconfirm "$pkg"; then
                info "Successfully installed $pkg"
            else
                error "Failed to install $pkg"
                failed_packages+=("$pkg")
            fi
        done
        if [ ${#failed_packages[@]} -ne 0 ]; then
            error "Failed to install the following packages: ${failed_packages[*]}"
            echo "Failed packages: ${failed_packages[*]}" >> "$LOG_FILE"
        fi
        info "Pacman packages installation complete."
    else
        info "All pacman packages are already installed."
    fi
}

# Function to install AUR packages
install_aur_packages() {
    local aur_cmd="$1"
    shift
    local packages_to_install=()
    local failed_packages=()
    for pkg in "$@"; do
        if is_installed "$pkg"; then
            info "Package $pkg is already installed. Skipping."
        else
            packages_to_install+=("$pkg")
        fi
    done
    if [ ${#packages_to_install[@]} -ne 0 ]; then
        info "Installing AUR packages using $aur_cmd: ${packages_to_install[*]}"
        for pkg in "${packages_to_install[@]}"; do
            if $aur_cmd -S --needed --noconfirm "$pkg"; then
                info "Successfully installed $pkg"
            else
                error "Failed to install $pkg"
                failed_packages+=("$pkg")
            fi
        done
        if [ ${#failed_packages[@]} -ne 0 ]; then
            error "Failed to install the following AUR packages: ${failed_packages[*]}"
            echo "Failed AUR packages: ${failed_packages[*]}" >> "$LOG_FILE"
        fi
        info "AUR packages installation complete."
    else
        info "All AUR packages are already installed."
    fi
}

# Function to setup PipeWire
setup_pipewire() {
    info "Setting up PipeWire..."
    install_packages pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
    
    # Enable PipeWire service
    systemctl --user enable pipewire.service
    systemctl --user enable pipewire-pulse.service
    
    info "PipeWire setup complete."
}

# Function to setup SDDM
setup_sddm() {
    info "Setting up SDDM..."
    install_packages sddm
    
    # Enable SDDM service
    sudo systemctl enable sddm.service
    
    info "SDDM setup complete."
}

# Function to setup Bluetooth
setup_bluetooth() {
    info "Setting up Bluetooth..."
    install_packages bluez bluez-utils
    
    # Enable Bluetooth service
    sudo systemctl enable bluetooth.service
    
    info "Bluetooth setup complete."
}

# Function to setup NVIDIA ( !!! WIP !!! )
setup_nvidia() {
    local install_nvidia=$(get_input "Do you have an NVIDIA GPU? (yes/no)" "no")
    if [[ "$install_nvidia" == "yes" ]]; then
        info "Setting up NVIDIA drivers..."
        install_packages nvidia-dkms nvidia-settings nvidia-utils libva libva-nvidia-driver-git
        
        # Add NVIDIA modules to mkinitcpio
        sudo sed -i 's/MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
        sudo mkinitcpio -P
        
        info "NVIDIA setup complete."
    else
        info "Skipping NVIDIA setup."
    fi
}

# Function for full installation
full_installation() {

    display_logo
    confirm_proceed "Running this will install necessary packages and dependencies together with my dotfiles. Do you want to proceed with the full installation? (yes/no)" "yes"
    
    info "Starting full installation..."
    
    # Install pacman packages
    install_packages kitty nano git rofi-wayland swaync waybar playerctl mpv grim slurp \
        cliphist wl-clipboard pavucontrol hyprlock nwg-look blueman bluez bluez-utils \
        dictd pamixer brightnessctl thunar ranger python-pillow imv \
        tumbler webp-pixbuf-loader totem evince ffmpegthumbnailer pacman-contrib btop \
        nvtop fastfetch neovim nm-connection-editor xdg-desktop-portal-hyprland unzip \
        swww hypridle ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono \
        ttf-space-mono-nerd noto-fonts-cjk noto-fonts-emoji

    # Install AUR packages
    install_aur_packages "$aur_helper" cava hyprpicker wl-clip-persist-git wlogout jamesdsp anyrun \
        catppuccin-gtk-theme-mocha nerd-fonts-sf-mono

    # Setup additional components
    setup_pipewire
    setup_sddm
    setup_bluetooth
    #setup_nvidia

    # Copy dotfiles
    copy_dotfiles

    # Enable system services
    enable_services

    info "Full installation complete."
}

# Function for base installation
base_installation() {
    
    display_logo
    confirm_proceed "Running this will install only the necessary packages and dependencies without my configs. Do you want to proceed with the base installation?" "yes"
      
    info "Starting base installation..."
    
    # Install pacman packages (excluding configuration-specific packages)
    install_packages kitty nano git rofi-wayland waybar playerctl mpv grim slurp \
        cliphist wl-clipboard pavucontrol blueman bluez bluez-utils \
        dictd pamixer brightnessctl thunar ranger python-pillow imv \
        tumbler webp-pixbuf-loader totem evince ffmpegthumbnailer pacman-contrib btop \
        nvtop fastfetch neovim nm-connection-editor xdg-desktop-portal-hyprland unzip \
        ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono \
        ttf-space-mono-nerd noto-fonts-cjk noto-fonts-emoji

    # Install AUR packages (excluding configuration-specific packages)
    install_aur_packages "$aur_helper" cava wl-clip-persist-git jamesdsp \
        catppuccin-gtk-theme-mocha nerd-fonts-sf-mono

    # Setup additional components
    setup_pipewire
    setup_sddm
    setup_bluetooth
    #setup_nvidia

    # Enable system services
    enable_services

    info "Base installation complete."
}

# Function to copy dotfiles
copy_dotfiles() {
    info "Copying dotfiles to home directory..."
    # First, ensure rsync is installed
    if ! command -v rsync &> /dev/null; then
        info "rsync not found. Installing rsync..."
        sudo pacman -S --needed --noconfirm rsync || error "Failed to install rsync"
    fi

    # Use rsync to copy files, creating directories if they don't exist
    rsync -avh --backup --backup-dir="$HOME/.config/dotfiles_backup_$(date +%Y%m%d_%H%M%S)" \
        dotfiles/dots/.config/ "$HOME/.config/" || error "Failed to copy dotfiles"
    info "Dotfiles copied successfully. Any existing files were backed up."
}

# Function to enable system services
enable_services() {
    info "Enabling system services..."
    
    services=(
        "bluetooth.service"
        "NetworkManager.service"
        "sddm.service"
        # Add other services as needed
    )

    for service in "${services[@]}"; do
        if sudo systemctl is-enabled --quiet "$service"; then
            info "$service is already enabled."
        else
            if sudo systemctl enable --now "$service"; then
                info "Successfully enabled $service"
            else
                error "Failed to enable $service"
            fi
        fi
    done

    info "System services setup complete."
}

display_help() {
    echo "Usage: ./install.sh [OPTION]"
    echo "Install and configure the system."
    echo
    echo "Options:"
    echo "  -h, --help     Display this help message and exit"
    echo "  -f, --full     Perform a full installation with configs."
    echo "  -b, --base     Perform a base installation without configs"
    echo "  -c, --config   Copy dotfiles to home directory"
    echo "  -s, --services Enable system services"
    echo
    echo "If no option is provided, a full installation will be performed."
}

# Main execution
main() {
    
    # Parse command-line arguments
    case "$1" in
        -h|--help)
            display_help
            exit 0
            ;;
        -f|--full)
            full_installation
            ;;
        -b|--base)
            base_installation
            ;;
        -c|--config)
            copy_dotfiles
            ;;
        -s|--services)
            enable_services
            ;;
        "")
            full_installation
            ;;
        *)
            echo "Error: Unknown option '$1'" >&2
            echo "Try './install.sh --help' for more information." >&2
            exit 1
            ;;
    esac

    info "Installation process complete!"
    info "Please check the log file at $LOG_FILE for any issues."
    info "Please restart your system or log out and log back in to apply all changes."
}

# Run the main function
main "$@"
