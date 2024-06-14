- Operating System • [Arch Linux](https://archlinux.org)
- Window Manager/DE • [Hyprland](https://hyprland.org/)
- Terminal • [kitty](https://github.com/kovidgoyal/kitty)
- Shell • zsh
- Aur Helper • [yay](https://github.com/Jguer/yay)
- Panel • [waybar](https://github.com/Alexays/Waybar)
- Launcher • [rofi](https://github.com/davatorium/rofi)
- File Manager • [thunar](https://wiki.archlinux.org/title/thunar)/[yazi](https://github.com/sxyazi/yazi)
- Notification Daemon • [swaync](https://github.com/ErikReider/SwayNotificationCenter)
- Wallpaper Daemon • [swww](https://github.com/LGFae/swww)
- Text Editor • [neovim](https://neovim.io/)
- Colorscheme • [catppuccin mocha](https://github.com/catppuccin/catppuccin)

## ⚙️ Setup
  > [!WARNING]
  > This is a step by step guide for installing my dotfiles which is designed based on Arch Linux (and other Arch-based distributions). If you are running any other system, install the following packages with your respective OS's package manager.

### Manual Installation
  > [!NOTE]
  > Assuming that your AUR helper is [yay.](https://github.com/Jguer/yay)
  > To install yay on your arch based system, follow the instructions mentioned [here.](https://github.com/Jguer/yay?tab=readme-ov-file#installation) 
  1. Installing git version of Hyprland
     
   ```bash
   yay -Sy hyprland-git
   ```

  2. Installing required dependencies     
    
   ```bash
   yay -Sy kitty nano rofi-wayland swaync waybar playerctl mpv grim slurp jq bc pamixer pavucontrol \
 waybar-cava cava xdg-desktop-portal-hyprland wl-clipboard socat cliphist hyprpicker \
 nm-connection-editor dictd wl-clip-persist-git blueman bluez bluez-utils nwg-look \
 wlogout ttf-space-mono-nerd brightnessctl neovim thunar imv yazi \
 catppuccin-gtk-theme-mocha nm-connection-editor btop nvtop fastfetch neofetch \
spicetify 
   ```

  3. Finally, Installing the dotfiles
     
  > Cloning the repository into your local system.
  ```bash
    git clone https://github.com/NotMugil/dotfiles.git
    cd dotfiles
  ```

  > Copy the configs to their respective directories. Make sure to backup your previous configs if needed. 
  ```bash
    cp -r config/* ~/.config/
    mkdir -p ~/.scripts
    cp -r scripts/* ~/.scripts/
  ```

Congratulations, you are done installing the configurations! 🎉 


## 🖼️ Gallery
>[!NOTE] 
> Images included in the gallery may contain some softwares which may not be included in the packages list or the configurations.


|  **Lockscreen**                                          |
| -------------------------------------------------------- |
| ![gallery-1](.github/assets/gallery-01.png)              |

| **Wallpaper Selector**                                   |
| -------------------------------------------------------- |
| ![gallery-2](.github/assets/gallery-02.png)              |

| **Custom Startpage for firefox**                         |
| -------------------------------------------------------- |
| ![gallery-3](.github/assets/gallery-03.png)              |

| **Spotify (Spicetified) & Audio Visualizer**             |
| -------------------------------------------------------- |
| ![gallery-4](.github/assets/gallery-04.png)              |

| **Rofi Menu from adi1090x**                              |
| -------------------------------------------------------- |
| ![gallery-5](.github/assets/gallery-05.png)              |

| **Notification Center (SwayNC)**                         |
| -------------------------------------------------------- |
| ![gallery-6](.github/assets/gallery-06.png)              |

| **Neofetch**                                             |
| -------------------------------------------------------- |
| ![gallery-7](.github/assets/gallery-07.png)              |

| **Btop + tty-clock**                                     |
| -------------------------------------------------------- |
| ![gallery-8](.github/assets/gallery-08.png)              |


## 💻 Development

### Known Issues
- [ ] Spacing in waybar style: minimal
- [ ] Auto refresh for bluetooth, battery module in waybar
- [ ] naming wallpapers with whitespaces causes issues with rofi
- [x] Rofi and wallpaper select only focuses after mouse movement (fixed by installing rofi-wayland instead of regular rofi)

### Tasks
- [ ] Symlink management
- [ ] Prepare Contrubuting.md
- [x] Wlogout configuration
- [x] More panel styles && panel selector

## Star History

## Star History

<a href="https://star-history.com/#NotMugil/dotfiles&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date" />
 </picture>
</a>

# Credits
_Thanks a lot for [r/unixporn](https://www.reddit.com/r/unixporn/) community for inspiring me to do this._

<div align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true"/>
</div>
