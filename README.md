<h3 align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
  <p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="285" /></p>
</h3>

<div align="center">
<p>
<a href="https://github.com/NotMugil/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/NotMugil/dotfiles?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=C9CBFF&labelColor=302D41" alt="stars"><a>
<a href="https://github.com/NotMugil/dotfiles/issues"><img alt="GitHub Issues or Pull Requests" src="https://img.shields.io/github/issues/NotMugil/dotfiles?style=for-the-badge&logo=gitbook&color=A6E3A1&logoColor=A6E3A1&labelColor=302D41"></a>
<a href="https://github.com/NotMugil/dotfiles?tab=GPL-3.0-1-ov-file"><img src="https://img.shields.io/github/license/NotMugil/dotfiles?style=for-the-badge&logo=&color=CBA6F7&logoColor=CBA6F7&labelColor=302D41" alt="LICENSE"></a>
</p>
</div>

![showcase](.github/assets/showcase.png)

## Information
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
    pacman -S kitty nano rofi-wayland swaync swaync waybar playerctl mpv grim slurp \
    cliphist wl-clipboard pavucontrol hyprlock nwg-look blueman bluez bluez-utils \
    dictd pamixer brightnessctl thunar ranger python-ranger-fm python-pillow imv \
    tumbler webp-pixbuf-loader totem evince ffmpegthumbnailer pacman-contrib btop \
    nvtop fastfetch neovim nm-connection-editor xdg-desktop-portal-hyprland zsh \
    unzip zsh swww hypridle 
   ```

   ```bash
     yay -Sy cava hyprpicker wl-clip-persist-git wlogout jamesdsp anyrun  \
     catppuccin-gtk-theme-mocha nerd-fonts-sf-mono 
   ```

   ```bash
    pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-space-mono-nerd \
    noto-fonts-cjk noto-fonts-emoji
   ```

  3. Finally, Installing the dotfiles
     
  > Cloning the repository into your local system.
  ```bash
    git clone --depth=1 https://github.com/NotMugil/dotfiles.git && cd dotfiles
  ```

  > Copy the configs to their respective directories. Make sure to backup your previous configs if needed. 
  ```bash
    cp -r .config/* ~/.config/
    cp -r .zshenv ~/
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
### Tasks
- [ ] Theme Switcher
- [ ] Ease the task of changing username/home dir name
- [ ] Update gallery images
- [ ] More Hyprlock styles
- [x] Add mpris to waybar

## ⭐ Star History
[![Star History Chart](https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date)](https://star-history.com/#NotMugil/dotfiles&Date)

# Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin) 
- [JaaKoolit's dotfiles](https://github.com/Jakoolit/hyprland-dots) 
- [Matt-ftw's dotfiles](https://github.com/Matt-ftw/dotfiles) 
- [gh0stzk's dotfiles](https://github.com/gh0stzk/dotfiles)
- [Hyprdots](https://github.com/prasanthrangan/hyprdots)
- [HyprNova](https://github.com/zDyanTB/HyprNova) 

_Thanks a lot for [r/unixporn](https://www.reddit.com/r/unixporn/) community for inspiring me to do this._

<div align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true"/>
</div>

<div align="right">
  <br>
  <a href="#top"><br><kbd> ^ </kbd><br></a>
</div>
